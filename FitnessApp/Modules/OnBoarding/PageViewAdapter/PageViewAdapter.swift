//
//  PageViewAdapter.swift
//  FitnessApp
//
//  Created by Allan on 29.06.23.
//

import Foundation
import UIKit

protocol AdapterActionDelegate: AnyObject {
    func finishOnBoarding()
}

final class PageViewAdapter: NSObject, PageViewAdapterProtocol {

    private weak var pageView: UIPageViewController?
    private weak var delegate: AdapterActionDelegate?
    
    private var pages: [UIViewController] = []
    private var initialPage: Int = 0
    
   
    //MARK: PageViewAdapterProtocol Functions
    func setupPageView(_ pageView: UIPageViewController, _ pages: [OnBoardingPageEnum], delegate: PageListsDelegate) {
        self.pageView = pageView
        self.pages =  pages.map { elem in
            return elem.getViewController(delegate: delegate)
        }
        setupPageView()
    }
    
    
    func nextTapped() {
           // delegate?.finishOnBoarding()

            goToNextPage()

        }
    
    func setupActionDelegate(_ delegate: AdapterActionDelegate) {
        self.delegate = delegate
    }
    
    //MARK: Private functions
    private func setupPageView() {
        pageView?.dataSource = self
       // pageView?.delegate = self
        
        setUp()
    }
    
    private func setUp() {
        pageView?.setViewControllers([pages[0]], direction: .forward, animated: true, completion: nil)
     }
    
}

////MARK: Delegate extension
//extension PageViewAdapter: UIPageViewControllerDelegate {
//    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
//        guard let viewControllers = pageViewController.viewControllers else { return }
//    }
//}

//MARK: Data Source extension
extension PageViewAdapter: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        if currentIndex == 0 {
            return pages.last
        } else{
            return pages[currentIndex - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]
        } else{
            return pages.first
        }
    }
}

//MARK: Navigation between pages
extension PageViewAdapter {
    func goToNextPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let pageView = pageView else { return }
        
        guard let currentPage = pageView.viewControllers?[0] else { return }
        if currentPage == pages.last {
            print("FinishOnBoarding")
           // delegate?.finishOnBoarding()
        } else {
            guard let nextPage = pageView.dataSource?.pageViewController(pageView,
                                                                         viewControllerAfter: currentPage) else { return }
    
            pageView.setViewControllers([nextPage], direction: .forward, animated: animated, completion: completion)

        }
    }
}
