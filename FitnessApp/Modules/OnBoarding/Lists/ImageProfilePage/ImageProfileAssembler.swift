//
//  ImagePickerAssembler.swift
//  FitnessApp
//
//  Created by Allan on 30.06.23.
//

import Foundation
import UIKit

final class ImageProfileAssembler {
    private init() { }
    
    static func makeVC(delegate: PageListsDelegate, typeOfScreen: OnBoardingPageEnum) -> UIViewController {
        let vm = makeVM(delegate: delegate, typeOfScreen: typeOfScreen)
        return ImageProfileList(viewModel: vm)
    }
    
    private static func makeVM(delegate: PageListsDelegate, typeOfScreen: OnBoardingPageEnum) -> ImageProfileVMProtocol {
        return ImageProfileVM(delegate: delegate,
                              typeOfScreen: typeOfScreen,
                              imagePickerAdapter: makeImagePickerAdapter())
    }
    
    private static func makeImagePickerAdapter() -> ImagePickerAdapterProtocol {
        return ImagePickerAdapter()
    }
    
}
