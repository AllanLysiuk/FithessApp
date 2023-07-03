//
//  NamePageAssembler.swift
//  FitnessApp
//
//  Created by Allan on 3.07.23.
//

import Foundation
import UIKit

final class NamePageAssembler {
    private init() { }
    
    static func makeVC(delegate: PageListsDelegate, typeOfScreen: OnBoardingPageEnum) -> UIViewController {
        let vm = makeVM(delegate,typeOfScreen)
        return NamePageList(viewModel: vm)
    }
    
    private static func makeVM(_ delegate: PageListsDelegate, _ typeOfScreen: OnBoardingPageEnum) -> NamePageVMProtocol {
        return NamePageVM(delegate: delegate, typeOfScreen: typeOfScreen)
    }
    
}
