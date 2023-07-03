//
//  PageViewAdapterProtocol.swift
//  FitnessApp
//
//  Created by Allan on 29.06.23.
//

import Foundation
import UIKit

protocol PageViewAdapterProtocol {
    func setupPageView(_ pageView: UIPageViewController, _ pages: [OnBoardingPageEnum], delegate: PageListsDelegate)
    func setupActionDelegate(_ delegate: AdapterActionDelegate)
    func nextTapped()
    func backTapped()
}
