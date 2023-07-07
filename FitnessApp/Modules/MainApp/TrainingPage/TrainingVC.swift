//
//  TrainingVC.swift
//  FitnessApp
//
//  Created by Allan on 23.06.23.
//

import Foundation
import UIKit

final class TrainingVC: UIViewController {
    private var startButton: UIButton!
    
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewsAndConstraints()
        setUpActions()
    }
}

// MARK: Actions
extension TrainingVC {
    private func setUpActions() {
        startButton.addTarget(self,
                             action: #selector(startButtonDidTap),
                             for: .touchUpInside)
    }
    
    
    @objc private func startButtonDidTap() {
        startButton.isSelected = !startButton.isSelected
        viewModel.startButonDidTap(isSelected: startButton.isSelected)
    }

}

// MARK: Set up UI
extension TrainingVC {
    
    private func setUpViewsAndConstraints() {
        view.backgroundColor = .white
      
        setUpStartButton()
        
    }

    private func setUpStartButton() {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.setTitle("Start", for: .normal)
        btn.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.backgroundColor = UIColor(red: 114.0 / 255.0, green:  101.0 / 255.0, blue:  227.0 / 255.0, alpha: 1)

        btn.layer.cornerRadius = 12.0
        btn.titleLabel?.font = .mSemiBold18
        view.addSubview(btn)
        startButton = btn
        
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

}

