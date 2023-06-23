//
//  ProfileVM.swift
//  FitnessApp
//
//  Created by Allan on 23.06.23.
//

import Foundation

final class ProfileVM: ProfileVMProtocol {
    private weak var coordinator: ProfileCoordinatorProtocol?
    
    init(coordinator: ProfileCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}
