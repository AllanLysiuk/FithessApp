//
//  LoginCoordinatorProtocol.swift
//  FitnessApp
//
//  Created by Allan on 22.06.23.
//

import Foundation
import UIKit

protocol LoginCoordinatorProtocol: AnyObject {
    func openRegisterScene(delegate: RegisterLoginDelegate, email: String?)
    func openForgotPasswordScene(delegate: ForgotPasswordLoginDelegate, email: String?)
    func finish()
    func presentAlert(_ alert: UIViewController)
}
