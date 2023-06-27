//
//  ForgotPasswordVMProtocol.swift
//  FitnessApp
//
//  Created by Allan on 22.06.23.
//

import Foundation

protocol ForgotPasswordVMProtocol {
    var email: String? { get set }
    
    func finish(shouldMoveToParent: Bool)
    func forgotPassword(email: String?)
}
