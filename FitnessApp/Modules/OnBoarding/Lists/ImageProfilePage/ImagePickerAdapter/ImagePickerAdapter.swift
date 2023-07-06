//
//  ImagePickerAdapter.swift
//  FitnessApp
//
//  Created by Allan on 30.06.23.
//

import Foundation
import UIKit

final class ImagePickerAdapter: NSObject {
    
    private weak var onBoardingDelegate: OnBoardingImagePickerAdapterDelegate?
    private weak var profileDelegate: ProfileImagePickerAdapterDelegate?
    
    private func imagePicker(sourceType: UIImagePickerController.SourceType) -> UIImagePickerController{
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        return imagePicker
    }
    
    private func setUpImagePicker() {
        let libraryImagePicker = self.imagePicker(sourceType: .photoLibrary)
        libraryImagePicker.delegate = self
        let libImagePicker = ViewContext(viewController: libraryImagePicker)
        if onBoardingDelegate != nil {
            onBoardingDelegate?.presentImagePicker(libImagePicker)
        } else {
            profileDelegate?.presentImagePicker(libImagePicker)
        }
     }
}

//MARK: Adapter protocol
extension ImagePickerAdapter: OnBoardingImagePickerAdapterProtocol {
    
    func showImagePicker() {
        self.setUpImagePicker()
    }
    
    func setUpDelegate(_ delegate: OnBoardingImagePickerAdapterDelegate) {
        self.onBoardingDelegate = delegate
    }

}

extension ImagePickerAdapter: ProfileImagePickerAdapterProtocol {
    func setUpDelegate(_ delegate: ProfileImagePickerAdapterDelegate) {
        self.profileDelegate = delegate
    }
    
}

//MARK: ImagePicker Delegate
extension ImagePickerAdapter: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        if onBoardingDelegate != nil {
            onBoardingDelegate?.imagePicked(image)
            onBoardingDelegate?.dismissImagePicker()
        } else {
            profileDelegate?.imagePicked(image)
            profileDelegate?.dismissImagePicker()
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        if onBoardingDelegate != nil {
            onBoardingDelegate?.dismissImagePicker()
        } else {
            profileDelegate?.dismissImagePicker()
        }
    }
}

