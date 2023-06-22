//
//  ForgotPasswordAssembler.swift
//  FitnessApp
//
//  Created by Allan on 22.06.23.
//

import Foundation
import UIKit

final class ForgotPasswordAssembler {
    private init() { }
    
    static func makeVC(coordinator: ForgotPasswordCoordinatorProtocol) -> UIViewController {
        let vm = makeVM(coordinator: coordinator)
        return ForgotPasswordVC(viewModel: vm)
    }
    
    private static func makeVM(coordinator: ForgotPasswordCoordinatorProtocol) -> ForgotPasswordVMProtocol {
        return ForgotPasswordVM(coordinator: coordinator)
    }
}
