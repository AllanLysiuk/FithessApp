//
//  LoginAssembler.swift
//  FitnessApp
//
//  Created by Allan on 22.06.23.
//

import Foundation
import UIKit

final class LoginAssembler {
    private init() { }
    
    static func makeVC(coordinator: LoginCoordinatorProtocol) -> UIViewController {
        let vm = makeVM(coordinator: coordinator)
        return LoginVC(viewModel: vm)
    }
    
    private static func makeVM(coordinator: LoginCoordinatorProtocol) -> LoginVMProtocol {
        return LoginVM(coordinator: coordinator)
    }
}
