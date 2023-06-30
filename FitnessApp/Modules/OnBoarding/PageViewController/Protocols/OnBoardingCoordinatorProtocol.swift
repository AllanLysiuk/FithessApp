//
//  OnBoardingCoordinatorProtocol.swift
//  FitnessApp
//
//  Created by Allan on 29.06.23.
//

import Foundation

protocol OnBoardingCoordinatorProtocol: AnyObject {
    func presentImagePicker(_ imagePicker: ViewContext)
    func dismissImagePicker()
    func finish()
}
