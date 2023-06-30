//
//  ImageProfileVMProtocol.swift
//  FitnessApp
//
//  Created by Allan on 30.06.23.
//

import Foundation

protocol ImageProfileVMProtocol {
    func setUpDelegate(_ delegate: ImageProfileVCDelegate)
    func showImagePicker()
    func saveTapped()
}
