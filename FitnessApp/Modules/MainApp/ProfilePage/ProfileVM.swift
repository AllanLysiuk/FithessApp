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
    private var authService: ProfileAuthServiceProtocol
    private var imagePickerAdapter: ProfileImagePickerAdapterProtocol
    private weak var profileVCDelegate: ProfileVCDelegate?
    
    init(
        coordinator: ProfileCoordinatorProtocol,
        coreDataService: ProfileCoreDataServiceProtocol,
        userDataService: ProfileUserDataServiceProtocol,
        imageService: ProfileImageServiceProtocol,
        authService: ProfileAuthServiceProtocol,
        imagePickerAdapter: ProfileImagePickerAdapterProtocol

    ) {
        self.coordinator = coordinator
        self.coreDataService = coreDataService
        self.userDataService = userDataService
        self.imageService = imageService
        self.authService = authService
        self.imagePickerAdapter = imagePickerAdapter
    }
    
    func logOut() {
        authService.signOut { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        self.userDataService.setIsRegisteredFlag(boolean: false)
        self.coordinator?.finish()
    }
    
    func loadProfile() -> Profile {
        let email = userDataService.getUserEmail()
        return coreDataService.loadAccInfoByEmail(email) ?? Profile()
    }
    
    func loadPhotoBy(_ relativePath: String) -> UIImage {
        var profileImage = UIImage()
        imageService.loadPhotoBy(relativePath: relativePath) { img in
            profileImage = img ?? UIImage(named: "defaul-profile-image")!
        }
        return profileImage
    }
    
    func updateInfoOfProfile(email: String, name: String, age: Int, weight: Double, growth: Double, gender: String, profileImage: UIImage?) {
        if let profileImage = profileImage {
            let path = imageService.saveImageToFileManager(profileImage: profileImage)
            let profileModel = ProfileModel(email: email, name: name, age: age, weight: weight, growth: growth, gender: gender, profileImagePath: path)
            coreDataService.updateInfoOfProfile(profileModel: profileModel)
        } else {
            //openAlert
        }
    }
    
    func setUpDelegate(_ delegate: ProfileVCDelegate) {
        self.profileVCDelegate = delegate
    }
    
    func showImagePicker() {
        imagePickerAdapter.setUpDelegate(self)
        imagePickerAdapter.showImagePicker()
    }
    
}

extension ProfileVM: ProfileImagePickerAdapterDelegate {
    func presentImagePicker(_ imagePicker: ViewContext) {
        coordinator?.presentImagePicker(imagePicker)
    }
    
    func dismissImagePicker() {
        coordinator?.dismissImagePicker()
    }
    
    func imagePicked(_ img: UIImage) {
        profileVCDelegate?.imagePicked(img)
    }
}
