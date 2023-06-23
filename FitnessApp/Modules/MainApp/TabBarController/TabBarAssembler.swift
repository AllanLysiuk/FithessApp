//
//  TabBarAssembler.swift
//  FitnessApp
//
//  Created by Allan on 23.06.23.
//

import Foundation

import UIKit

final class TabBarAssembler {
    
    private init() { }
    
    static func makeTabBarController(coordinator: TabBarCoordinatorProtocol) -> UITabBarController {
        return TabBarController()
    }
    
    
}
