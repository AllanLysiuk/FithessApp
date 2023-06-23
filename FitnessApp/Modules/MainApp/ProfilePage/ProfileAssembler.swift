//
//  ProfileAssembler.swift
//  FitnessApp
//
//  Created by Allan on 23.06.23.
//

import Foundation
import UIKit

final class ProfileAssembler {
    private init() { }
    
    static func makeProfileVC(coordinator: ProfileCoordinatorProtocol) -> UIViewController {
        return ProfileVC(viewModel: makeViewModel(coordinator: coordinator))
    }
    
    private static func makeViewModel(coordinator: ProfileCoordinatorProtocol) -> ProfileVMProtocol {
        return ProfileVM(coordinator: coordinator)
    }
}
