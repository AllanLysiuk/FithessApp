//
//  PageListsDelegate.swift
//  FitnessApp
//
//  Created by Allan on 30.06.23.
//

import Foundation

protocol PageListsDelegate: AnyObject {
    func saveButtonTapped(by typeOfScreen: OnBoardingPageEnum, with value: Any)
    func presentImagePicker(_ imagePicker: ViewContext)
    func dismissImagePicker()
}
