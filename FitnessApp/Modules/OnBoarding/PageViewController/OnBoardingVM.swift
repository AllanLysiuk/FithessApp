//
//  OnBoardingVM.swift
//  FitnessApp
//
//  Created by Allan on 29.06.23.
//

import Foundation
import UIKit

final class OnBoardingVM: OnBoardingViewModelProtocol {

    var pages: [OnBoardingPageEnum] = [.nameScreen, .genderScreen, .ageScreen, .growthScreen, .weightScreen, .profileImageScreen]
    private var profileModel = ProfileModel(email: "", name: "", age: 0, weight: 0, growth: 0, gender: "Male", profileImagePath: "")
    
    private var adapter: PageViewAdapterProtocol
    private var imageService: OnBoardingImageServiceProtocol
    private weak var coordinator: OnBoardingCoordinatorProtocol?
    private var userDataService: OnBoardingUserDataServiceProtocol
    
    init(
        coordinator: OnBoardingCoordinatorProtocol,
        adapter: PageViewAdapterProtocol,
        imageService: OnBoardingImageServiceProtocol,
        userDataService: OnBoardingUserDataServiceProtocol
    ) {
        self.coordinator = coordinator
        self.adapter = adapter
        self.imageService = imageService
        self.userDataService = userDataService
        self.adapter.setupActionDelegate(self)
    }
    
    func setUp(with pageView: UIPageViewController) {
        adapter.setupPageView(pageView, pages, delegate: self)
    }
    
    func goToPreviousPage() {
        adapter.backTapped()
    }
    
}

extension OnBoardingVM: PageListsDelegate {
    func presentImagePicker(_ imagePicker: ViewContext) {
        coordinator?.presentImagePicker(imagePicker)
    }
    
    func dismissImagePicker() {
        coordinator?.dismissImagePicker()
    }
    
    func saveButtonTapped(by typeOfScreen: OnBoardingPageEnum, with value: Any) {
        switch typeOfScreen {
        case .nameScreen:
            profileModel.email = userDataService.getUserEmail()
            profileModel.name = String(describing: value)
        case .genderScreen:
            profileModel.gender = String(describing: value)
        case .ageScreen:
            profileModel.age = value as? Int ?? 0
        case .growthScreen:
            profileModel.growth = value as? Int ?? 0
        case .weightScreen:
            profileModel.weight = value as? Int ?? 0
        case .profileImageScreen:
            let img = value as? UIImage
            if let img = img {
                let path = imageService.saveImageToFileManager(profileImage: img)
                profileModel.profileImagePath = path
            }
        }
        adapter.nextTapped()
    }
}

extension OnBoardingVM: AdapterActionDelegate {
    func finishOnBoarding() {
        userDataService.setOnBoardingFlag(boolean: true)
        coordinator?.finish()
    }
}
