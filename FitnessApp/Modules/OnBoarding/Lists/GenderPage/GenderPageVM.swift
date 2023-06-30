//
//  GenderPageVM.swift
//  FitnessApp
//
//  Created by Allan on 30.06.23.
//

import Foundation
import UIKit

final class GenderPageVM: GenderVMProtocol {
    
    private weak var delegate: PageListsDelegate?
    private var typeOfScreen: OnBoardingPageEnum
    
    init(
        delegate: PageListsDelegate,
        typeOfScreen: OnBoardingPageEnum
    ) {
        self.delegate = delegate
        self.typeOfScreen = typeOfScreen
    }
    
    func saveTapped(gender: String) {
        delegate?.saveButtonTapped(by: typeOfScreen, with: gender)
    }
}
