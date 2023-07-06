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
    
    static func makeProfileVC(coordinator: ProfileCoordinatorProtocol, container: Container) -> UIViewController {
        return ProfileVC(viewModel: makeViewModel(coordinator: coordinator, container: container))
    }
    
    private static func makeViewModel(coordinator: ProfileCoordinatorProtocol, container: Container) -> ProfileVMProtocol {
        return ProfileVM(
            coordinator: coordinator,
            coreDataService: makeCoreDataService(container: container),
            userDataService: makeUserDataService(container: container),
            imageService: makeImageService(container: container),
            authService: makeAuthService(container: container),
            imagePickerAdapter: makeImagePickerAdapter()
        )
    }
    
    private static func makeImageService(container: Container) -> ImageServiceProtocol {
        return container.resolve()
    }
    
    private static func makeUserDataService(container: Container) -> UserDataServiceProtocol {
        return container.resolve()
    }
    
    private static func makeCoreDataService(container: Container) -> CoreDataServiceProtocol {
        return container.resolve()
    }
    
    private static func makeAuthService(container: Container) -> AuthServiceProtocol {
        return container.resolve()
    }
    
    private static func makeImagePickerAdapter() -> ProfileImagePickerAdapterProtocol {
        return ImagePickerAdapter()
    }
}
