//
//  OnBoardingVC.swift
//  FitnessApp
//
//  Created by Allan on 29.06.23.
//

import Foundation
import UIKit

final class OnBoardingVC: UIPageViewController {
    
    private var viewModel: OnBoardingViewModelProtocol
    
    init(viewModel: OnBoardingViewModelProtocol) {
        self.viewModel = viewModel
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [.interPageSpacing: 0])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setUp(with: self)
        setUpActions()
    }
    
}

//MARK: Actions
extension OnBoardingVC {
    private func setUpActions() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action:  #selector(backTapped(_:)))
       
    }
    
    @objc func backTapped(_ sender: UIButton) {
        viewModel.goToPreviousPage()
    }
}
