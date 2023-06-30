//
//  OnBoardingAssembler.swift
//  FitnessApp
//
//  Created by Allan on 29.06.23.
//

import Foundation
import UIKit

final class OnBoardingAssembler {
    private init() { }
    
    static func makeOnBoardingVC(coordinator: OnBoardingCoordinatorProtocol) -> UIPageViewController {
        let vc = OnBoardingVC(viewModel: makeViewModel(coordinator: coordinator))
        return vc
    }
    
    private static func makeViewModel(coordinator: OnBoardingCoordinatorProtocol) -> OnBoardingViewModelProtocol {
        return OnBoardingVM(coordinator: coordinator, adapter: makeAdapter())
    }
    
    private static func makeAdapter() -> PageViewAdapterProtocol {
        return PageViewAdapter()
    }
    
}
