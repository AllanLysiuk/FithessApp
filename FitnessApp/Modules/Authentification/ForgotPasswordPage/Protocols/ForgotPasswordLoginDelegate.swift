//
//  ForgotPasswordLoginDelegate.swift
//  FitnessApp
//
//  Created by Allan on 27.06.23.
//

import Foundation

protocol ForgotPasswordLoginDelegate: AnyObject {
    func passwordChanged(with email: String)
}
