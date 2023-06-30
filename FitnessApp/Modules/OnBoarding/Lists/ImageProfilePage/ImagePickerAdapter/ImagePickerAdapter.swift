//
//  ImagePickerAdapter.swift
//  FitnessApp
//
//  Created by Allan on 30.06.23.
//

import Foundation
import UIKit

final class ImagePickerAdapter: NSObject {
    
    private weak var delegate: ImageProfilePageDelegate?
    
    private func imagePicker(sourceType: UIImagePickerController.SourceType) -> UIImagePickerController{
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        return imagePicker
    }
    
    private func setUpImagePicker() {
         let libraryImagePicker = self.imagePicker(sourceType: .photoLibrary)
         libraryImagePicker.delegate = self
        let libImagePicker = ViewContext(viewController: libraryImagePicker)
        // self.present(libraryImagePicker, animated: true)
     }
}

//MARK: Adapter protocol
extension ImagePickerAdapter: ImagePickerAdapterProtocol {
    
    func showImagePicker() {
        self.setUpImagePicker()
    }
    
    func setUpDelegate(_ delegate: ImageProfilePageDelegate) {
        self.delegate = delegate
    }

}

//MARK: ImagePicker Delegate
extension ImagePickerAdapter: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        delegate?.imagePicked(image)
//        self.profileImage.image = image
//        if profileImage.image != nil{
//            imageInfoLabel.text = nil
//        }
        //self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
      //  self.dismiss(animated: true)
    }
}

