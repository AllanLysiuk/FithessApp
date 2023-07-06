//
//  ImageProfilePageDelegate.swift
//  FitnessApp
//
//  Created by Allan on 30.06.23.
//

import Foundation
import UIKit

protocol OnBoardingImagePickerAdapterDelegate: AnyObject {
    func imagePicked(_ img: UIImage)
    func presentImagePicker(_ imagePicker: ViewContext)
    func dismissImagePicker()
}
