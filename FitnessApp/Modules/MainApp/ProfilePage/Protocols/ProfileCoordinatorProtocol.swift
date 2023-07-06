//
//  ProfileCoordinatorProtocol.swift
//  FitnessApp
//
//  Created by Allan on 23.06.23.
//

import Foundation

protocol ProfileCoordinatorProtocol: AnyObject {
    func presentImagePicker(_ imagePicker: ViewContext)
    func dismissImagePicker()
    func finish()
}
