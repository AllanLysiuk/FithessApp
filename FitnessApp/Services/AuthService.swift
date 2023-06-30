//
//  AuthService.swift
//  FitnessApp
//
//  Created by Allan on 25.06.23.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift

final class AuthService: AuthServiceProtocol {
    
    func login(email: String, password: String, completion: @escaping (_ error: Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            completion(error)
        }
    }
    
    func signInWithGoogle(viewContext: ViewContext, completion: @escaping (_ error: Error?) -> Void) {

        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
    
        GIDSignIn.sharedInstance.signIn(withPresenting: viewContext.viewController) { result, error in
            let user = result?.user
            guard let idToken = user?.idToken else {
                print("ID Token missing")
                return
            }
            if let accessToken = user?.accessToken {
                let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
                Auth.auth().signIn(with: credential) { dataRes, error in
//                    dataRes?.user
                    completion(error)
                }
            }
        }
    }
    
    func register(email: String, password: String, completion: @escaping (_ error: Error?) -> Void){
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            completion(error)
        }
    }
    
    func forgotPassword(email: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            completion(error)
        }
    }
}
