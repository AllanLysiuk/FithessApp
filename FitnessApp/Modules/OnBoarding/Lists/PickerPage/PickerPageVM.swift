//
//  AgePageVM.swift
//  FitnessApp
//
//  Created by Allan on 30.06.23.
//

import Foundation
import UIKit

final class PickerPageVM: PickerVMProtocol {
    
    private weak var delegate: PageListsDelegate?
    private var pickerViewAdapter: PickerViewAdapterProtocol
    private var typeOfScreen: OnBoardingPageEnum
    init(
        delegate: PageListsDelegate,
        pickerViewAdapter: PickerViewAdapterProtocol,
        typeOfScreen: OnBoardingPageEnum
    ) {
        self.delegate = delegate
        self.pickerViewAdapter = pickerViewAdapter
        self.typeOfScreen = typeOfScreen
    }
    
    func setUpPickerView(_ pickerView: UIPickerView) {
        pickerViewAdapter.setUpPickerView(pickerView)
    }
    
    func setUpRangeOfItems() {
        switch typeOfScreen {
        case .ageScreen:
            pickerViewAdapter.setUpRangeOfItems(NSRange(location: 0, length: 121))
        case .growthScreen:
            pickerViewAdapter.setUpRangeOfItems(NSRange(location: 0, length: 261))
        case .weightScreen:
            pickerViewAdapter.setUpRangeOfItems(NSRange(location: 0, length: 401))
        default:
            assert(false, "Wrong call of assembler in OnBoardingPageEnum")
        }
    }
    
    func saveTapped() {
        let selectedValue = pickerViewAdapter.selectedValue
        delegate?.saveButtonTapped(by: self.typeOfScreen, with: selectedValue)
    }

}
