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
    
    static func makeOnBoardingVC(coordinator: OnBoardingCoordinatorProtocol, container: Container) -> UIPageViewController {
        let vc = OnBoardingVC(viewModel: makeViewModel(coordinator: coordinator, container: container))
        return vc
    }
    
    private static func makeViewModel(
        coordinator: OnBoardingCoordinatorProtocol,
        container: Container
    ) -> OnBoardingViewModelProtocol {
        return OnBoardingVM(
            coordinator: coordinator,
            adapter: makeAdapter(),
            imageService: makeImageService(container: container),
            userDataService: makeUserDataService(container: container),
            coreDataService: makeCoreDataService(container: container)
        )
    }
    
    private static func makeAdapter() -> PageViewAdapterProtocol {
        return PageViewAdapter()
    }
    
    private static func makeImageService(container: Container) -> ImageServiceProtocol {
        return container.resolve()
    }
    
    private static func makeUserDataService(container: Container) -> UserDataServiceProtocol {
        return container.resolve()
    }
    
    private static func makeCoreDataService(container: Container) -> CoreDataServiceProtocol {
        return container.resolve()
    }
}
