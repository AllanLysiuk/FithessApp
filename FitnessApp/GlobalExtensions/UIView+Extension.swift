//
//  UIView+Extension.swift
//  FitnessApp
//
//  Created by Allan on 29.06.23.
//

import Foundation
import UIKit

extension UIView {
    func shake(duration: TimeInterval = 0.5, xValue: CGFloat = 12, yValue: CGFloat = 0) {
        self.transform = CGAffineTransform(translationX: xValue, y: yValue)
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    func startWobble() {
        let angle = Double.pi / 180.0;
        self.transform = CGAffineTransform.identity.rotated(by: CGFloat(-angle));
        UIView.animate(withDuration: 0.15, delay: 0, options: [.allowUserInteraction,.repeat,.autoreverse], animations: {
             self.transform = CGAffineTransform.identity.rotated(by: CGFloat(angle));
        }, completion: nil)

    }

    func stopWobble() {
        UIView.animate(withDuration: 0.15, delay: 0, options: [.allowUserInteraction,.beginFromCurrentState,.curveLinear], animations: {
            self.transform = CGAffineTransform.identity;
        }, completion: nil)
    }
}
