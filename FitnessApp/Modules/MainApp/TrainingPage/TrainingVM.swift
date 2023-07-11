//
//  TrainingVM.swift
//  FitnessApp
//
//  Created by Allan on 23.06.23.
//

import Foundation
import MapKit

final class TrainingVM: TrainingVMProtocol {
    
    private weak var coordinator: TrainingCoordinatorProtocol?
    private var healthKitService: TrainingHealthKitServiceProtocol
    private var userDataService: TrainingUserDataServiceProtocol
    private var mapAdapter: MapAdapterProtocol
    private weak var delegate: TrainingVCDelegate?
    private var startDate = Date()
    
    private var distanceWalking: Double?
    private var steps: Double?
    private var calories: Double?
    private var avgSpeed: Double?
    
    private var timerCounting:Bool = false
    private var startTime:Date?
    private var stopTime:Date?
    private var locationUpdatingTimer: Int = 0
    private var locations: [CLLocationCoordinate2D] = []
    private var scheduledTimer: Timer!
    
    init(
        coordinator: TrainingCoordinatorProtocol,
        healthKitService: TrainingHealthKitServiceProtocol,
        userDataService: TrainingUserDataServiceProtocol,
        mapAdapter: MapAdapterProtocol
    ) {
        self.coordinator = coordinator
        self.healthKitService = healthKitService
        self.userDataService = userDataService
        self.mapAdapter = mapAdapter
    }
    
    func setUpDelegate(_ delegate: TrainingVCDelegate) {
        self.delegate = delegate
    }
    
    func setUpMapView(_ mapView: MKMapView) {
        mapAdapter.setUpMapView(mapView)
    }
    
    func setUpMapItems() {
        guard let latitude = userDataService.getLastLocationLatitude(),
              let longitude = userDataService.getLastLocationLongitude() else { return }
        for i in 0..<latitude.count {
            locations.append(CLLocationCoordinate2D(latitude: latitude[i], longitude: longitude[i]))
        }
       // mapAdapter.setUpItems(locations)
    }
    
    func startButonDidTap(isSelected: Bool) {
        startStopButtonDidTap()
        if isSelected {
            healthKitService.authorizeHealthKit { authorized, error in
                guard authorized else {
                    let baseMessage = "HealthKit Authorization Failed"
                    
                    if let error = error {
                        print("\(baseMessage). Reason: \(error.localizedDescription)")
                    } else {
                        print(baseMessage)
                    }
                    return
                }
            }
            startDate = .now
        } else {
            delegate?.startAnimatingIndicator()
            let group = DispatchGroup()
            
            group.enter()
            healthKitService.loadInfoByType(.distance, since: startDate, to: .now) { res, error in
                if let error = error {
                    print(error.localizedDescription + "  1")
                } else {
                    self.distanceWalking = res
                }
                group.leave()
            }
            
            group.enter()
            healthKitService.loadInfoByType(.steps, since: startDate, to: .now) { res, error in
                if let error = error {
                    print(error.localizedDescription + "  2")
                } else {
                    self.steps = res
                }
                group.leave()
            }
            
            group.enter()
            healthKitService.loadInfoByType(.speed, since: startDate, to: .now) { res, error in
                if let error = error {
                    print(error.localizedDescription + "  3")
                } else {
                    self.avgSpeed = res
                }
                group.leave()
            }
            
            group.enter()
            healthKitService.loadInfoByType(.calories, since: startDate, to: .now) { res, error in
                if let error = error {
                    print(error.localizedDescription + "  4")
                } else {
                    self.calories = res
                }
                group.leave()
            }
            
            group.notify(queue: .main) {
                self.delegate?.endAnimatingIndictor(distance: self.distanceWalking, steps: self.steps, calories: self.calories, avgSpeed: self.avgSpeed)
            }
            
        }
    }
    
    private func resetArr() {
        userDataService.setLastLocationLatitude(latitude: [])
        userDataService.setLastLocationLongitude(longitude: [])
    }
}

//MARK: Timer
extension TrainingVM {
    
    func checkTimer() {
        startTime = userDataService.getStartTime()
        stopTime = userDataService.getStopTime()
        timerCounting = userDataService.getTimerCounting()
        mapAdapter.setUpItems(locations)
        if timerCounting {
            startTimer()
        } else {
            stopTimer()
            if let start = startTime {
                if let stop = stopTime {
                    let time = calcRestartTime(start: start, stop: stop)
                    let diff = Date().timeIntervalSince(time)
                    setTimeLabel(Int(diff))
                }
            }
        }
    }
    
    func startStopButtonDidTap() {
        if timerCounting {
            setStopTime(date: Date())
            stopTimer()
        } else {
            if let stop = stopTime {
                let restartTime = calcRestartTime(start: startTime!, stop: stop)
                setStopTime(date: nil)
                setStartTime(date: restartTime)
            } else {
                setStartTime(date: Date())
            }
            
            startTimer()
        }
    }
    
    func calcRestartTime(start: Date, stop: Date) -> Date {
        let diff = start.timeIntervalSince(stop)
        return Date().addingTimeInterval(diff)
    }
    
    func startTimer() {
        scheduledTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(refreshValue), userInfo: nil, repeats: true)
        setTimerCounting(true)
        delegate?.setButtonSelection(isSelected: true)
    }
    
    @objc func refreshValue() {
        if let start = startTime {
            let diff = Date().timeIntervalSince(start)
            setTimeLabel(Int(diff))
        } else {
            stopTimer()
            setTimeLabel(0)
        }
    }
    
    func setTimeLabel(_ val: Int) {
        let time = secondsToHoursMinutesSeconds(val)
        if time.1 - locationUpdatingTimer >= 1 {
            mapAdapter.updateLocation()
            locationUpdatingTimer = time.1
        }
        delegate?.setTimeLabel(makeTimeString(hour: time.0, min: time.1, sec: time.2))
    }
    
    func secondsToHoursMinutesSeconds(_ ms: Int) -> (Int, Int, Int) {
        let hour = ms / 3600
        let min = (ms % 3600) / 60
        let sec = (ms % 3600) % 60
        return (hour, min, sec)
    }
    
    func makeTimeString(hour: Int, min: Int, sec: Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", hour)
        timeString += ":"
        timeString += String(format: "%02d", min)
        timeString += ":"
        timeString += String(format: "%02d", sec)
        return timeString
    }
    
    func stopTimer() {
        if scheduledTimer != nil {
            scheduledTimer.invalidate()
        }
        setTimerCounting(false)
        delegate?.setButtonSelection(isSelected: false)
    }
    
    func resetButtonDidTap() {
        resetArr()
        setStopTime(date: nil)
        setStartTime(date: nil)
        delegate?.setTimeLabel(makeTimeString(hour: 0, min: 0, sec: 0))
        stopTimer()
    }
    
    func setStartTime(date: Date?) {
        startTime = date
        userDataService.setStartTime(startTime: startTime)
    }
    
    func setStopTime(date: Date?) {
        stopTime = date
        userDataService.setStopTime(stopTime: stopTime)
    }
    
    func setTimerCounting(_ val: Bool) {
        timerCounting = val
        userDataService.setTimerCounting(timerCounting: timerCounting)
    }
}

extension TrainingVM: MapAdapterDelegate {
    func returnCurrentLocation(latitude: [Double], longitude: [Double]) {
        userDataService.setLastLocationLatitude(latitude: latitude)
        userDataService.setLastLocationLongitude(longitude: longitude)
    }
}
