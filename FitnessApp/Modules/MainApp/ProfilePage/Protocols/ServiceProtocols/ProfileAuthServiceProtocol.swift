//
//  ProfileAuthServiceProtocol.swift
//  FitnessApp
//
//  Created by Allan on 5.07.23.
//

import Foundation

protocol ProfileAuthServiceProtocol {
    func signOut(completion: @escaping (_ error: Error?) -> Void)
}
