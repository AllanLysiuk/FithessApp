//
//  ProfileVM.swift
//  FitnessApp
//
//  Created by Allan on 23.06.23.
//

import Foundation
import UIKit

final class ProfileVM: ProfileVMProtocol {

    private weak var coordinator: ProfileCoordinatorProtocol?
    private var coreDataService: ProfileCoreDataServiceProtocol
    private var userDataService: ProfileUserDataServiceProtocol
    private var imageService: ProfileImageServiceProtocol
    
    init(
        coordinator: ProfileCoordinatorProtocol,
        coreDataService: ProfileCoreDataServiceProtocol,
        userDataService: ProfileUserDataServiceProtocol,
        imageService: ProfileImageServiceProtocol
    ) {
        self.coordinator = coordinator
        self.coreDataService = coreDataService
        self.userDataService = userDataService
        self.imageService = imageService
    }
    
    func loadProfile() -> Profile {
        let email = userDataService.getUserEmail()
        return coreDataService.loadAccInfoByEmail(email)
    }
    
    func loadPhotoBy(_ relativePath: String) -> UIImage {
        var profileImage = UIImage()
        imageService.loadPhotoBy(relativePath: relativePath) { img in
            profileImage = img ?? UIImage(named: "defaul-profile-image")!
        }
        return profileImage
    }
    
    func updateInfoOfProfile(email: String, name: String, age: Int, weight: Double, growth: Double, gender: String, profileImage: UIImage?) {
        
    }
    
    
    
}
