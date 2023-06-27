//
//  LoginVMProtocol.swift
//  FitnessApp
//
//  Created by Allan on 22.06.23.
//

import Foundation

protocol LoginVMProtocol {
    func openRegisterPage(with email: String?)
    func openForgotPasswordPage(with email: String?)
    func login(email: String?, password: String?)
    func setupViewDelegate(_ delegate: LoginVCDelegate)
}
