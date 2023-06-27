//
//  ForgotPasswordCoordinatorProtocol.swift
//  FitnessApp
//
//  Created by Allan on 22.06.23.
//

import Foundation
import UIKit

protocol ForgotPasswordCoordinatorProtocol: AnyObject {
    func presentAlert(_ alert: UIViewController)
    func finish(shouldMoveToParent: Bool)
}
