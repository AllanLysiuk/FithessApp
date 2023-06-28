//
//  UILabel+Extension.swift
//  FitnessApp
//
//  Created by Allan on 25.06.23.
//

import Foundation
import UIKit

extension UILabel {
    
    func setupLabel(text: String, color: UIColor, fontName: UIFont) {
        self.text = text
        self.textColor = color
        self.font = fontName
        self.translatesAutoresizingMaskIntoConstraints = false
    }

}
