//
//  TrainingVC.swift
//  FitnessApp
//
//  Created by Allan on 23.06.23.
//

import Foundation
import UIKit
import MapKit


final class TrainingVC: UIViewController {
    private var mapView: MKMapView!
    private var timeLabel: UILabel!
    private var timeCounterLabel: UILabel!
    private var distanceWalkingCounterLabel: UILabel!
    private var stepsCounterLabel: UILabel!
    private var caloriesCounterLabel: UILabel!
    private var avgSpeedCounterLabel: UILabel!
    private var distanceWalkingLabel: UILabel!
    private var stepsLabel: UILabel!
    private var caloriesLabel: UILabel!
    private var avgSpeedLabel: UILabel!
    private var spinner: UIActivityIndicatorView!
    private var backgroundButtonsView: UIView!
    private var betweenButtonsView: UIView!
    private var startButton: UIButton!
    private var resetButton: UIButton!
    
    private var viewModel: TrainingVMProtocol
    
    init(viewModel: TrainingVMProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        requiredInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func requiredInit() {
        tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "figure.walk"), tag: 0)
        navigationController?.tabBarItem = tabBarItem
        viewModel.setUpDelegate(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewsAndConstraints()
        setUpActions()
        viewModel.setUpMapView(mapView)
        viewModel.setUpMapItems()
        viewModel.checkTimer()
    }
}

// MARK: Actions
extension TrainingVC {
    private func setUpActions() {
        startButton.addTarget(self,
                             action: #selector(startButtonDidTap),
                             for: .touchUpInside)
        resetButton.addTarget(self,
                              action: #selector(resetButtonDidTap),
                              for: .touchUpInside)
    }
    
    
    @objc private func startButtonDidTap() {
        startButton.isSelected = !startButton.isSelected
        viewModel.startButonDidTap(isSelected: startButton.isSelected)
    }
    
    @objc private func resetButtonDidTap() {
        stepsCounterLabel.text = "0.0"
        distanceWalkingCounterLabel.text = "0.0"
        caloriesCounterLabel.text = "0.0"
        avgSpeedCounterLabel.text = "0.0"
        viewModel.resetButtonDidTap()
    }

}

// MARK: Set up UI
extension TrainingVC {

    private func setUpViewsAndConstraints() {
        view.backgroundColor = .white
        
        setUpMapView()
        
        setUpTimeLabel()
        setUpTimeCounterLabel()
        
        setUpDistanceWalkingLabel()
        setUpDistanceWalkingCounterLabel()
        
        setUpStepsLabel()
        setUpStepsCounterLabel()
        
        setUpCaloriesLabel()
        setUpCaloriesCounterLabel()
        
        setUpAvgSpeedLabel()
        setUpAvgSpeedCounterLabel()
        
        setUpActivityIndicator()
        
        setUpBackgroundButtonsView()
        setUpBetweenButtonsView()
        
        setUpStartButton()
        setUpResetButton()
        
    }
    
    private func setUpMapView() {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.mapType = MKMapType.standard
        map.isZoomEnabled = true
        map.isScrollEnabled = true
        view.addSubview(map)
        mapView = map
        
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.heightAnchor.constraint(equalToConstant: 300.0)
        ])
    }
    
    private func setUpTimeLabel() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setupLabel(text: "Training time", color: .black, fontName: (.mSemiBold16 ?? .systemFont(ofSize: 16, weight: .semibold)) )
        view.addSubview(label)
        self.timeLabel = label
        
        NSLayoutConstraint.activate([
            timeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            timeLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 8.0),
            timeLabel.widthAnchor.constraint(equalToConstant: (view.frame.width / 2) - 24)
        ])
        
    }
    
    private func setUpTimeCounterLabel() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setupLabel(text: "00:00:00", color: .black, fontName: (.mSemiBold18 ?? .systemFont(ofSize: 18, weight: .semibold)) )
        view.addSubview(label)
        self.timeCounterLabel = label
        
        NSLayoutConstraint.activate([
            timeCounterLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            timeCounterLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 0.0),
            timeCounterLabel.widthAnchor.constraint(equalTo: timeLabel.widthAnchor)
        ])
        
    }

    private func setUpDistanceWalkingLabel() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setupLabel(text: "Walking Distance", color: .black, fontName: (.mSemiBold16 ?? .systemFont(ofSize: 16, weight: .semibold)) )
        view.addSubview(label)
        self.distanceWalkingLabel = label
        
        NSLayoutConstraint.activate([
            distanceWalkingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20.0),
            distanceWalkingLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 8.0),
            distanceWalkingLabel.widthAnchor.constraint(equalTo: timeLabel.widthAnchor)
        ])
        
    }
    
    private func setUpDistanceWalkingCounterLabel() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setupLabel(text: "0.0", color: .black, fontName: (.mSemiBold18 ?? .systemFont(ofSize: 18, weight: .semibold)) )
        view.addSubview(label)
        self.distanceWalkingCounterLabel = label
        
        NSLayoutConstraint.activate([
            distanceWalkingCounterLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20.0),
            distanceWalkingCounterLabel.topAnchor.constraint(equalTo: distanceWalkingLabel.bottomAnchor, constant: 0.0),
            distanceWalkingCounterLabel.widthAnchor.constraint(equalTo: distanceWalkingLabel.widthAnchor)
        ])
        
    }
    
    private func setUpStepsLabel() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setupLabel(text: "Steps", color: .black, fontName: (.mSemiBold16 ?? .systemFont(ofSize: 16, weight: .semibold)) )
        view.addSubview(label)
        self.stepsLabel = label
        
        NSLayoutConstraint.activate([
            stepsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            stepsLabel.topAnchor.constraint(equalTo: timeCounterLabel.bottomAnchor, constant: 20.0),
            stepsLabel.widthAnchor.constraint(equalTo: timeLabel.widthAnchor)
        ])
    }
    
    private func setUpStepsCounterLabel() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setupLabel(text: "0.0", color: .black, fontName: (.mSemiBold18 ?? .systemFont(ofSize: 18, weight: .semibold)) )
        view.addSubview(label)
        self.stepsCounterLabel = label
        
        NSLayoutConstraint.activate([
            stepsCounterLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            stepsCounterLabel.topAnchor.constraint(equalTo: stepsLabel.bottomAnchor, constant: 0.0),
            stepsCounterLabel.widthAnchor.constraint(equalTo: stepsLabel.widthAnchor)
        ])
    }
    
    private func setUpCaloriesLabel() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setupLabel(text: "Calories", color: .black, fontName: (.mSemiBold16 ?? .systemFont(ofSize: 16, weight: .semibold)) )
        view.addSubview(label)
        self.caloriesLabel = label
        
        NSLayoutConstraint.activate([
            caloriesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20.0),
            caloriesLabel.topAnchor.constraint(equalTo: distanceWalkingCounterLabel.bottomAnchor, constant: 20.0),
            caloriesLabel.widthAnchor.constraint(equalTo: timeLabel.widthAnchor)
        ])
    }
    
    private func setUpCaloriesCounterLabel() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setupLabel(text: "0.0", color: .black, fontName: (.mSemiBold18 ?? .systemFont(ofSize: 18, weight: .semibold)) )
        view.addSubview(label)
        self.caloriesCounterLabel = label
        
        NSLayoutConstraint.activate([
            caloriesCounterLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20.0),
            caloriesCounterLabel.topAnchor.constraint(equalTo: caloriesLabel.bottomAnchor, constant: 0.0),
            caloriesCounterLabel.widthAnchor.constraint(equalTo: caloriesLabel.widthAnchor)
        ])
    }
    
    private func setUpAvgSpeedLabel() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setupLabel(text: "Average running speed", color: .black, fontName: (.mSemiBold16 ?? .systemFont(ofSize: 16, weight: .semibold)) )
        view.addSubview(label)
        self.avgSpeedLabel = label
        
        NSLayoutConstraint.activate([
            avgSpeedLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            avgSpeedLabel.topAnchor.constraint(equalTo: stepsCounterLabel.bottomAnchor, constant: 20.0),
            avgSpeedLabel.widthAnchor.constraint(equalTo: timeLabel.widthAnchor)
        ])
    }
    
    private func setUpAvgSpeedCounterLabel() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setupLabel(text: "0.0", color: .black, fontName: (.mSemiBold18 ?? .systemFont(ofSize: 18, weight: .semibold)) )
        view.addSubview(label)
        self.avgSpeedCounterLabel = label
        
        NSLayoutConstraint.activate([
            avgSpeedCounterLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            avgSpeedCounterLabel.topAnchor.constraint(equalTo: avgSpeedLabel.bottomAnchor, constant: 0.0),
            avgSpeedCounterLabel.widthAnchor.constraint(equalTo: avgSpeedLabel.widthAnchor)
        ])
    }
    
    private func setUpActivityIndicator() {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.style = .large
        activityIndicator.hidesWhenStopped = true
        activityIndicator.stopAnimating()
        view.addSubview(activityIndicator)
        
        spinner = activityIndicator
        
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setUpBackgroundButtonsView() {
        let bckView = UIView()
        bckView.translatesAutoresizingMaskIntoConstraints = false
        bckView.backgroundColor = UIColor(red: 114.0 / 255.0, green:  101.0 / 255.0, blue:  227.0 / 255.0, alpha: 1)
        bckView.layer.cornerRadius = 125
        view.addSubview(bckView)
        backgroundButtonsView = bckView
        
        NSLayoutConstraint.activate([
            backgroundButtonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundButtonsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20.0),
            backgroundButtonsView.heightAnchor.constraint(equalToConstant: 250.0),
            backgroundButtonsView.widthAnchor.constraint(equalToConstant: 250.0)
        ])
    }
    
    private func setUpBetweenButtonsView() {
        let btwView = UIView()
        btwView.translatesAutoresizingMaskIntoConstraints = false
        btwView.backgroundColor = .clear
        view.addSubview(btwView)
        betweenButtonsView = btwView
        
        NSLayoutConstraint.activate([
            betweenButtonsView.centerXAnchor.constraint(equalTo: backgroundButtonsView.centerXAnchor),
            betweenButtonsView.centerYAnchor.constraint(equalTo: backgroundButtonsView.centerYAnchor),
            betweenButtonsView.heightAnchor.constraint(equalToConstant: 1),
            betweenButtonsView.widthAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    private func setUpStartButton() {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.setTitle("Start", for: .normal)
        btn.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.backgroundColor = UIColor(red: 114.0 / 255.0, green:  101.0 / 255.0, blue:  227.0 / 255.0, alpha: 1)

        btn.setTitle("Stop", for: .selected)
        
        btn.layer.cornerRadius = 10.0
        btn.titleLabel?.font = .mSemiBold20
        view.addSubview(btn)
        startButton = btn
        
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: backgroundButtonsView.centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: betweenButtonsView.topAnchor, constant: 0.0),
        ])
    }
    
    private func setUpResetButton() {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.setTitle("Reset", for: .normal)
        btn.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.backgroundColor = UIColor(red: 114.0 / 255.0, green:  101.0 / 255.0, blue:  227.0 / 255.0, alpha: 1)
        
        btn.layer.cornerRadius = 10.0
        btn.titleLabel?.font = .mSemiBold20
        view.addSubview(btn)
        resetButton = btn
        
        NSLayoutConstraint.activate([
            resetButton.centerXAnchor.constraint(equalTo: backgroundButtonsView.centerXAnchor),
            resetButton.topAnchor.constraint(equalTo: betweenButtonsView.bottomAnchor, constant: 0.0),
        ])
    }
}

//MARK: TrainingVC delegate
extension TrainingVC: TrainingVCDelegate {
    func startAnimatingIndicator() {
        self.view.isUserInteractionEnabled = false
        spinner.startAnimating()
    }
    
    func endAnimatingIndictor(distance: Double?, steps: Double?, calories: Double?, avgSpeed: Double?) {
        self.view.isUserInteractionEnabled = true
        var dist = (distance ?? 0.0)
        var stp = steps ?? 0.0
        var cal = calories ?? 0.0
        var avg = avgSpeed ?? 0.0
        if let previousDist = Double(distanceWalkingCounterLabel.text ?? "0.0"),
           let previousSteps = Double(stepsCounterLabel.text ?? "0.0"),
           let previousCal = Double(caloriesCounterLabel.text ?? "0.0"),
           let previousSpeed = Double(avgSpeedCounterLabel.text ?? "0.0")
        {
            dist += previousDist
            stp += previousSteps
            cal += previousCal
            avg += previousSpeed
        }
        
        distanceWalkingCounterLabel.text = String(describing: dist)
        stepsCounterLabel.text = String(describing: stp)
        caloriesCounterLabel.text = String(describing: cal)
        avgSpeedCounterLabel.text = String(describing: avg / 2)
        spinner.stopAnimating()
    }
    
    func setTimeLabel(_ timeString: String) {
        timeCounterLabel.text = timeString
    }
    
    func setButtonSelection(isSelected: Bool) {
        startButton.isSelected = isSelected
    }
}

//MARK: Private funcs
extension TrainingVC {
    
}
