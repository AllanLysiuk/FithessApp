//
//  OnBoardingVM.swift
//  FitnessApp
//
//  Created by Allan on 29.06.23.
//

import Foundation
import UIKit

final class OnBoardingVM: OnBoardingViewModelProtocol {

    var pages: [OnBoardingPageEnum] = [.genderScreen, .ageScreen, .growthScreen, .weightScreen, .profileImageScreen]
    
    
    private var adapter: PageViewAdapterProtocol
    private var pageControl: UIPageControl?
    private weak var coordinator: OnBoardingCoordinatorProtocol?
    
    init(coordinator: OnBoardingCoordinatorProtocol, adapter: PageViewAdapterProtocol) {
        self.coordinator = coordinator
        self.adapter = adapter
        self.adapter.setupActionDelegate(self)
    }
    
    func setUp(with pageView: UIPageViewController) {
        adapter.setupPageView(pageView, pages, delegate: self)
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
        adapter.nextTapped()
    }
}

extension OnBoardingVM: AdapterActionDelegate {
    
    #warning("user defaults")
    func finishOnBoarding() {
        let ud = UserDefaults()
       // ud.set(true, forKey: UserDefaultsEnum.shouldShowOnboarding)
        coordinator?.finish()
    }
}
