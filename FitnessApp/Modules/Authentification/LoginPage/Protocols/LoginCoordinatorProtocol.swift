//
//  LoginCoordinatorProtocol.swift
//  FitnessApp
//
//  Created by Allan on 22.06.23.
//

import Foundation

protocol LoginCoordinatorProtocol: AnyObject {
    func openRegisterScene()
    func openForgotPasswordScene()
    func finish()
}
