//
//  ImageProfileVM.swift
//  FitnessApp
//
//  Created by Allan on 30.06.23.
//

import Foundation
import UIKit

final class ImageProfileVM: ImageProfileVMProtocol {
    private var imagePickerAdapter: ImagePickerAdapterProtocol
    private weak var pageListsDelegate: PageListsDelegate?
    private weak var imageProfileVCDelegate: ImageProfileVCDelegate?
    private var typeOfScreen: OnBoardingPageEnum
    
    init(
        delegate: PageListsDelegate,
        typeOfScreen: OnBoardingPageEnum,
        imagePickerAdapter: ImagePickerAdapterProtocol
    ) {
        self.pageListsDelegate = delegate
        self.typeOfScreen = typeOfScreen
        self.imagePickerAdapter = imagePickerAdapter
    }
    
    func setUpDelegate(_ delegate: ImageProfileVCDelegate) {
        self.imageProfileVCDelegate = delegate
    }
    
    func showImagePicker() {
        imagePickerAdapter.setUpDelegate(self)
        imagePickerAdapter.showImagePicker()
    }
    
    func saveTapped(img: UIImage) {
        pageListsDelegate?.saveButtonTapped(by: typeOfScreen, with: img)
    }
}

extension ImageProfileVM: ImageProfilePageDelegate {
    func presentImagePicker(_ imagePicker: ViewContext) {
        pageListsDelegate?.presentImagePicker(imagePicker)
    }
    
    func dismissImagePicker() {
        pageListsDelegate?.dismissImagePicker()
    }
    
    func imagePicked(_ img: UIImage) {
        imageProfileVCDelegate?.imagePicked(img)
    }
}
