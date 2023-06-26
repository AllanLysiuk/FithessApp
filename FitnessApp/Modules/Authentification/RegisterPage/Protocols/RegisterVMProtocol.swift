//
//  RegisterVMProtocol.swift
//  FitnessApp
//
//  Created by Allan on 22.06.23.
//

import Foundation

protocol RegisterVMProtocol {
    func register(email: String?, password: String?, checkPassword: String?)
    func finish(shouldMoveToParent: Bool)
}
