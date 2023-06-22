//
//  Coordinator.swift
//  FitnessApp
//
//  Created by Allan on 22.06.23.
//

import Foundation

protocol Coordinator: AnyObject {
    
    var childCoordinators: [Coordinator] { get }
    
    func start()
    func finish()
}
