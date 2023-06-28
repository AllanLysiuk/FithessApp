//
//  LoginAuthServiceProtocol.swift
//  FitnessApp
//
//  Created by Allan on 25.06.23.
//

import Foundation

protocol LoginAuthServiceProtocol {
    func login(email: String, password: String, completion: @escaping (_ error: Error?) -> Void)
    func signInWithGoogle(viewContext: ViewContext, completion: @escaping (_ error: Error?) -> Void) 
}
