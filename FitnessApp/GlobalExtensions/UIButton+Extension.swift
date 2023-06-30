//
//  UIButton+Extension.swift
//  FitnessApp
//
//  Created by Allan on 26.06.23.
//

import Foundation
import UIKit

extension UIButton{
    
    func secureButtonToggle(isSecure: Bool){
        if !isSecure{
           self.setImage(UIImage(systemName: "eye"), for: .normal)
        }else{
          self.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }
    }
    
    func unselectButton() {
        self.isSelected = false
        self.backgroundColor = .white
    }
    
    func createTitleInTwoLines(btnTitle: String, firstLineFont: UIFont, secondLineFont: UIFont) {
        self.titleLabel?.lineBreakMode = .byWordWrapping
        self.titleLabel?.textAlignment = .center
        let btnTitle: NSString = btnTitle as NSString
        let newlineRange: NSRange = btnTitle.range(of: "\n")
        var subString1 = ""
        var subString2 = ""
        if(newlineRange.location != NSNotFound) {
            subString1 = btnTitle.substring(to: newlineRange.location)
            subString2 = btnTitle.substring(from: newlineRange.location)
            }
        let attributes1 = [NSMutableAttributedString.Key.font: firstLineFont]
        let attrString1 = NSMutableAttributedString(string: subString1, attributes: attributes1)
    
        let attributes2 = [NSMutableAttributedString.Key.font: secondLineFont]
        let attrString2 = NSMutableAttributedString(string: subString2, attributes: attributes2)
    
        attrString1.append(attrString2)
        self.setAttributedTitle(attrString1, for: [])
    }
}
