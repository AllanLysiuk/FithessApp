//
//  RegisterCoordinatorProtocol.swift
//  FitnessApp
//
//  Created by Allan on 22.06.23.
//

import Foundation
import UIKit

protocol RegisterCoordinatorProtocol: AnyObject {
    func finish(shouldMoveToParent: Bool)
    func presentAlert(_ alert: ViewContext)
}
