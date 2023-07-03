//
//  OnBoardingImageServiceProtocol.swift
//  FitnessApp
//
//  Created by Allan on 3.07.23.
//

import Foundation
import UIKit

protocol OnBoardingImageServiceProtocol {
    func saveImageToFileManager(profileImage: UIImage) -> String
}
