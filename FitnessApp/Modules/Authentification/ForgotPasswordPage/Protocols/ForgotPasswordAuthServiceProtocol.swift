//
//  ForgotPasswordAuthServiceProtocol.swift
//  FitnessApp
//
//  Created by Allan on 25.06.23.
//

import Foundation

protocol ForgotPasswordAuthServiceProtocol {
    func forgotPassword(email: String, completion: @escaping (Error?) -> Void)
}
