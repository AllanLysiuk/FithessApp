//
//  ProfileVMProtocol.swift
//  FitnessApp
//
//  Created by Allan on 23.06.23.
//

import Foundation
import UIKit

protocol ProfileVMProtocol {
    func loadProfile() -> Profile
    func loadPhotoBy(_ relativePath: String) -> UIImage
    func updateInfoOfProfile(email: String, name: String, age: Int, weight: Double, growth: Double, gender: String, profileImage: UIImage?)
}
