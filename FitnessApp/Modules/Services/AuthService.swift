//
//  AuthService.swift
//  FitnessApp
//
//  Created by Allan on 25.06.23.
//

import Foundation

final class AuthService: AuthServiceProtocol{
    
    func login(email: String, password: String, completion: @escaping (_ error: Error?) -> Void) {
    
    }
    
    func register(email: String, password: String, completion: @escaping (_ error: Error?) -> Void){
       
    }
    
    func forgotPassword(email: String, completion: @escaping (Error?) -> Void) {
      
    }
}
