//
//  OnBoardingPageEnum.swift
//  FitnessApp
//
//  Created by Allan on 29.06.23.
//

import Foundation
import UIKit

enum OnBoardingPageEnum {
    case genderScreen
    case ageScreen
    case growthScreen
    case weightScreen
    case profileImageScreen
    
    func getViewController(delegate: PageListsDelegate) -> UIViewController {
        switch self {
        case .genderScreen:
            return GenderPageAssembler.makeVC(delegate: delegate, typeOfScreen: self)
        case .ageScreen:
            return PickerPageAssembler.makeVC(delegate: delegate, text: "Select your age", typeOfScreen: self)
        case .growthScreen:
            return PickerPageAssembler.makeVC(delegate: delegate, text: "Select your growth in cm", typeOfScreen: self)
        case .weightScreen:
            return PickerPageAssembler.makeVC(delegate: delegate, text: "Select your weight in kg", typeOfScreen: self)
        case .profileImageScreen:
            return ImageProfileAssembler.makeVC(delegate: delegate, typeOfScreen: self)
        }
    }
    
}
