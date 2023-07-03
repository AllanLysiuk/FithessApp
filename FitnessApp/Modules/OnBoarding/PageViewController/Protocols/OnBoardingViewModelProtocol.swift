//
//  OnBoardingViewModelProtocol.swift
//  FitnessApp
//
//  Created by Allan on 29.06.23.
//

import Foundation
import UIKit
protocol OnBoardingViewModelProtocol: AnyObject {
    func setUp(with pageView: UIPageViewController)
    func goToPreviousPage()
}
