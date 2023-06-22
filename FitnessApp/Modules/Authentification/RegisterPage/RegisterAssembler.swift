//
//  RegisterAssembler.swift
//  FitnessApp
//
//  Created by Allan on 22.06.23.
//

import Foundation
import UIKit

final class RegisterAssembler {
    
    private init() { }
    
    static func makeRegisterVC(coordinator: RegisterCoordinatorProtocol) -> UIViewController {
        let vm = makeViewModel(coordinator: coordinator)
        return RegisterVC(viewModel: vm)
    }
    
    private static func makeViewModel(coordinator: RegisterCoordinatorProtocol) -> RegisterVMProtocol {
        return RegisterVM(coordinator: coordinator)
    }
    
}
