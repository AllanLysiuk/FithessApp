//
//  RegisterAuthServiceProtocol.swift
//  FitnessApp
//
//  Created by Allan on 25.06.23.
//

import Foundation

protocol RegisterAuthServiceProtocol {
    func register(email: String, password: String, completion: @escaping (_ error: Error?) -> Void)
}
