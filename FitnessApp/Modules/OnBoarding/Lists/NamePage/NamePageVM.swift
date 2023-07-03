//
//  NamePageVM.swift
//  FitnessApp
//
//  Created by Allan on 3.07.23.
//

import Foundation
import UIKit

final class NamePageVM: NamePageVMProtocol {
    
    private weak var delegate: PageListsDelegate?
    private var typeOfScreen: OnBoardingPageEnum
    
    init(
        delegate: PageListsDelegate,
        typeOfScreen: OnBoardingPageEnum
    ) {
        self.delegate = delegate
        self.typeOfScreen = typeOfScreen
    }
    
    func saveTapped(name: String) {
        delegate?.saveButtonTapped(by: typeOfScreen, with: name)
    }
}
