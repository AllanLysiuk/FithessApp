//
//  LoginVMProtocol.swift
//  FitnessApp
//
//  Created by Allan on 22.06.23.
//

import Foundation

protocol LoginVMProtocol {
    func openRegisterPage()
    func openForgotPasswordPage()
    func login(email: String, password: String)
}
