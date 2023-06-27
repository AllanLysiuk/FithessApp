//
//  RegisterLoginDelegate.swift
//  FitnessApp
//
//  Created by Allan on 27.06.23.
//

import Foundation

protocol RegisterLoginDelegate: AnyObject {
    func registerFinished(with email: String)
}
