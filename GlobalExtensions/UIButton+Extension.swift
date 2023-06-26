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
}
