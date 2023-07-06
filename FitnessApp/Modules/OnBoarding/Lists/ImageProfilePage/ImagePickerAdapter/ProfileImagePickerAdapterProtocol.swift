//
//  ProfileImagePickerAdapterProtocol.swift
//  FitnessApp
//
//  Created by Allan on 6.07.23.
//

import Foundation

protocol ProfileImagePickerAdapterProtocol {
    func showImagePicker()
    func setUpDelegate(_ delegate: ProfileImagePickerAdapterDelegate)
}
