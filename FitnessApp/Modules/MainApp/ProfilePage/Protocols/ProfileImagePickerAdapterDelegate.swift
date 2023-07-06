//
//  ProfileImagePickerAdapterDelegate.swift
//  FitnessApp
//
//  Created by Allan on 6.07.23.
//

import Foundation
import UIKit

protocol ProfileImagePickerAdapterDelegate: AnyObject {
    func imagePicked(_ img: UIImage)
    func presentImagePicker(_ imagePicker: ViewContext)
    func dismissImagePicker()
}
