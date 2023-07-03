//
//  AgeAssembler.swift
//  FitnessApp
//
//  Created by Allan on 30.06.23.
//

import Foundation
import UIKit

final class PickerPageAssembler {
    private init() { }
    
    static func makeVC(delegate: PageListsDelegate, text: String, typeOfScreen: OnBoardingPageEnum) -> UIViewController {
        let vm = makeVM(delegate,typeOfScreen)
        return PickerPageList(viewModel: vm, titleLabelText: text)
    }
    
    private static func makeVM(_ delegate: PageListsDelegate, _ typeOfScreen: OnBoardingPageEnum) -> PickerVMProtocol {
        return PickerPageVM(delegate: delegate, pickerViewAdapter: makePickerViewAdapter(), typeOfScreen: typeOfScreen)
    }
    
    private static func makePickerViewAdapter() -> PickerViewAdapterProtocol {
        return PickerViewAdapter()
    }
}
