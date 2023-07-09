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
        container.register({Self.imageService})
        container.register({Self.coreDataService})
        container.register({Self.heakthKitService})
    }
    
}

protocol AuthServiceProtocol: AnyObject, LoginAuthServiceProtocol & ForgotPasswordAuthServiceProtocol & RegisterAuthServiceProtocol, ProfileAuthServiceProtocol { }

protocol AlertFactoryProtocol: AnyObject, AlertControllerFactoryProtocol { }

protocol UserDataServiceProtocol: AnyObject, LoginUserDataServiceProtocol, OnBoardingUserDataServiceProtocol, ProfileUserDataServiceProtocol, TrainingUserDataServiceProtocol { }

protocol ImageServiceProtocol: AnyObject, OnBoardingImageServiceProtocol, ProfileImageServiceProtocol { }

protocol CoreDataServiceProtocol: AnyObject, OnBoardingCoreDataServiceProtocol, ProfileCoreDataServiceProtocol, LoginCoreDataServiceProtocol { }

protocol HealthKitServiceProtocol: AnyObject, TrainingHealthKitServiceProtocol {}

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
    
    static var imageService: ImageServiceProtocol {
        return ImageService()
    }
    
    static var coreDataService: CoreDataServiceProtocol {
        return CoreDataService()
    }
    
    static var heakthKitService: HealthKitServiceProtocol {
        return HealthKitService()
    }
}
