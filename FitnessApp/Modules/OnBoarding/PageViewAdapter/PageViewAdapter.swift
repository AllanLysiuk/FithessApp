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
        goToNextPage()
    }
    
    func backTapped() {
        goToPreviousPage()
    }
    
    func setupActionDelegate(_ delegate: AdapterActionDelegate) {
        self.delegate = delegate
    }
    
    //MARK: Private functions
    private func setupPageView() {
        pageView?.dataSource = self
        setUp()
    }
    
    private func setUp() {
        removeSwipeGesture()
        pageView?.setViewControllers([pages[0]], direction: .forward, animated: true, completion: nil)
     }
    
    private func removeSwipeGesture() {
        for view in self.pageView!.view.subviews {
                if let subView = view as? UIScrollView {
                    subView.isScrollEnabled = false
                }
            }
    }
}

//MARK: Data Source extension
extension PageViewAdapter: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        if currentIndex == 0 {
            return pages[currentIndex]
        } else{
            return pages[currentIndex - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]
        } else{
            return pages[currentIndex]
        }
    }
}

//MARK: Navigation between pages
extension PageViewAdapter {
    func goToNextPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let pageView = pageView else { return }
        
        guard let currentPage = pageView.viewControllers?[0] else { return }
        if currentPage == pages.last {
           delegate?.finishOnBoarding()
        } else {
            guard let nextPage = pageView.dataSource?.pageViewController(pageView,
                                                                viewControllerAfter: currentPage) else { return }
    
            pageView.setViewControllers([nextPage], direction: .forward, animated: animated, completion: completion)

        }
    }
    
    func goToPreviousPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let pageView = pageView else { return }
        
        guard let currentPage = pageView.viewControllers?[0] else { return }
        if currentPage != pages.first {
            guard let nextPage = pageView.dataSource?.pageViewController(pageView, viewControllerBefore: currentPage) else { return }
    
            pageView.setViewControllers([nextPage], direction: .reverse, animated: animated, completion: completion)
        }
    }
}
