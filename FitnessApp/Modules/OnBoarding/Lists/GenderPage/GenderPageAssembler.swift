//
//  GenderPageAssembler.swift
//  FitnessApp
//
//  Created by Allan on 30.06.23.
//

import Foundation
import UIKit

final class GenderPageAssembler {
    private init() { }
    
    static func makeVC(delegate: PageListsDelegate, typeOfScreen: OnBoardingPageEnum) -> UIViewController {
        let vm = makeVM(delegate,typeOfScreen)
        return GenderPageList(viewModel: vm)
    }
    
    private static func makeVM(_ delegate: PageListsDelegate, _ typeOfScreen: OnBoardingPageEnum) -> GenderVMProtocol {
        return GenderPageVM(delegate: delegate, typeOfScreen: typeOfScreen)
    }
    
}
