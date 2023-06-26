//
//  ServiceConfigurations.swift
//  FitnessApp
//
//  Created by Allan on 25.06.23.
//

import Foundation

final class ServiceConfigurations {
    
    private init() {  }
    
    static func configure(container: Container) {
        container.register({ Self.authService })
    }
    
}

protocol AuthServiceProtocol: AnyObject, LoginAuthServiceProtocol & ForgotPasswordAuthServiceProtocol & RegisterAuthServiceProtocol { }

private extension ServiceConfigurations {
    
    static var authService: AuthServiceProtocol {
        return AuthService()
    }
    
}
