//
//  TrainingVC.swift
//  FitnessApp
//
//  Created by Allan on 23.06.23.
//

import Foundation
import UIKit

final class TrainingVC: UIViewController {
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
        viewModel.resetButtonDidTap()
    }

}

// MARK: Set up UI
extension TrainingVC {

    private func setUpViewsAndConstraints() {
        view.backgroundColor = .white
        
        setUpBackgroundButtonsView()
        setUpBetweenButtonsView()
        
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
        
        setUpStartButton()
        setUpResetButton()
        
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
    
    private func setUpTimeLabel() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setupLabel(text: "Training time", color: .black, fontName: (.mSemiBold30 ?? .systemFont(ofSize: 30, weight: .semibold)) )
        view.addSubview(label)
        self.timeLabel = label
        
        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8.0)
        ])
        
    }
    
    private func setUpTimeCounterLabel() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setupLabel(text: "00:00:00", color: .black, fontName: (.mSemiBold32 ?? .systemFont(ofSize: 32, weight: .semibold)) )
        view.addSubview(label)
        self.timeCounterLabel = label
        
        NSLayoutConstraint.activate([
            timeCounterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeCounterLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 8.0)
        ])
        
    }

    private func setUpDistanceWalkingLabel() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setupLabel(text: "Walking Distance", color: .black, fontName: (.mSemiBold30 ?? .systemFont(ofSize: 30, weight: .semibold)) )
        view.addSubview(label)
        self.distanceWalkingLabel = label
        
        NSLayoutConstraint.activate([
            distanceWalkingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            distanceWalkingLabel.topAnchor.constraint(equalTo: timeCounterLabel.bottomAnchor, constant: 8.0)
        ])
        
    }
    
    private func setUpDistanceWalkingCounterLabel() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setupLabel(text: "0.0", color: .black, fontName: (.mSemiBold32 ?? .systemFont(ofSize: 32, weight: .semibold)) )
        view.addSubview(label)
        self.distanceWalkingCounterLabel = label
        
        NSLayoutConstraint.activate([
            distanceWalkingCounterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            distanceWalkingCounterLabel.topAnchor.constraint(equalTo: distanceWalkingLabel.bottomAnchor, constant: 8.0)
        ])
        
    }
    
    private func setUpStepsLabel() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setupLabel(text: "Steps", color: .black, fontName: (.mSemiBold30 ?? .systemFont(ofSize: 30, weight: .semibold)) )
        view.addSubview(label)
        self.stepsLabel = label
        
        NSLayoutConstraint.activate([
            stepsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stepsLabel.topAnchor.constraint(equalTo: distanceWalkingCounterLabel.bottomAnchor, constant: 8.0)
        ])
    }
    
    private func setUpStepsCounterLabel() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setupLabel(text: "0.0", color: .black, fontName: (.mSemiBold32 ?? .systemFont(ofSize: 32, weight: .semibold)) )
        view.addSubview(label)
        self.stepsCounterLabel = label
        
        NSLayoutConstraint.activate([
            stepsCounterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stepsCounterLabel.topAnchor.constraint(equalTo: stepsLabel.bottomAnchor, constant: 8.0)
        ])
    }
    
    private func setUpCaloriesLabel() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setupLabel(text: "Calories", color: .black, fontName: (.mSemiBold30 ?? .systemFont(ofSize: 30, weight: .semibold)) )
        view.addSubview(label)
        self.caloriesLabel = label
        
        NSLayoutConstraint.activate([
            caloriesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            caloriesLabel.topAnchor.constraint(equalTo: stepsCounterLabel.bottomAnchor, constant: 8.0)
        ])
    }
    
    private func setUpCaloriesCounterLabel() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setupLabel(text: "0.0", color: .black, fontName: (.mSemiBold32 ?? .systemFont(ofSize: 32, weight: .semibold)) )
        view.addSubview(label)
        self.caloriesCounterLabel = label
        
        NSLayoutConstraint.activate([
            caloriesCounterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            caloriesCounterLabel.topAnchor.constraint(equalTo: caloriesLabel.bottomAnchor, constant: 8.0)
        ])
    }
    
    private func setUpAvgSpeedLabel() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setupLabel(text: "Average running speed", color: .black, fontName: (.mSemiBold30 ?? .systemFont(ofSize: 30, weight: .semibold)) )
        view.addSubview(label)
        self.avgSpeedLabel = label
        
        NSLayoutConstraint.activate([
            avgSpeedLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avgSpeedLabel.topAnchor.constraint(equalTo: caloriesCounterLabel.bottomAnchor, constant: 8.0)
        ])
    }
    
    private func setUpAvgSpeedCounterLabel() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setupLabel(text: "0.0", color: .black, fontName: (.mSemiBold32 ?? .systemFont(ofSize: 32, weight: .semibold)) )
        view.addSubview(label)
        self.avgSpeedCounterLabel = label
        
        NSLayoutConstraint.activate([
            avgSpeedCounterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avgSpeedCounterLabel.topAnchor.constraint(equalTo: avgSpeedLabel.bottomAnchor, constant: 8.0)
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
        let dist = distance ?? 0.0
        let stp = steps ?? 0.0
        let cal = calories ?? 0.0
        let avg = avgSpeed ?? 0.0
        distanceWalkingCounterLabel.text = String(describing: dist)
        stepsCounterLabel.text = String(describing: stp)
        caloriesCounterLabel.text = String(describing: cal)
        avgSpeedCounterLabel.text = String(describing: avg)
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
