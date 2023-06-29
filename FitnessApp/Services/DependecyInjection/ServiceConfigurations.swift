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
        container.register({Self.alertFactory})
        container.register({Self.userDataService})
    }
    
}

protocol AuthServiceProtocol: AnyObject, LoginAuthServiceProtocol & ForgotPasswordAuthServiceProtocol & RegisterAuthServiceProtocol { }

protocol AlertFactoryProtocol: AnyObject, AlertControllerFactoryProtocol { }

protocol UserDataServiceProtocol: AnyObject, LoginUserDataServiceProtocol {}

private extension ServiceConfigurations {
    
    static var authService: AuthServiceProtocol {
        return AuthService()
    }
    
    static var alertFactory: AlertFactoryProtocol {
        return AlertControllerFactory()
    }
    
    static var userDataService: UserDataServiceProtocol {
        return UserDataService()
    }
}
