//
//  ProfileImageServiceProtocol.swift
//  FitnessApp
//
//  Created by Allan on 4.07.23.
//

import Foundation
import UIKit

protocol ProfileImageServiceProtocol {
    func saveImageToFileManager(profileImage: UIImage) -> String
    func loadPhotoBy(relativePath: String?, completion: @escaping ((UIImage?) -> Void))
}
