//
//  PageControllerAdapter.swift
//  DDArt
//
//  Created by Даниил Ярмоленко on 03.11.2022.
//

import UIKit

final class PageViewControllerSegmentedAdapter: NSObject {
    
    private let pageViewController: UIPageViewController
    fileprivate let segmentControl: DDSegmentControl
    fileprivate let viewControllers: [UIViewController]
    fileprivate var selectedIndex = 0 {
        didSet {
            segmentControl.buttonAction(buttonIndex: selectedIndex)
        }
    }
    
    init(pageViewController: UIPageViewController, viewControllers: [UIViewController], segmentControl: DDSegmentControl) {
        
        self.segmentControl = segmentControl
        self.pageViewController = pageViewController
        self.viewControllers = viewControllers
        super.init()
        
        pageViewController.delegate = self
        pageViewController.dataSource = self
        segmentControl.delegate = self
        if let firstViewController = viewControllers.first {
            pageViewController.setViewControllers([firstViewController], direction: .forward, animated: true)
        }
    }
    
    private func setViewController(atIndex index: Int, direction: UIPageViewController.NavigationDirection) {
        self.pageViewController.setViewControllers([self.viewControllers[index]], direction: direction, animated: true) { [weak self] completed in
            guard let me = self else {
                return
            }
            if completed {
                me.selectedIndex = index
            }
        }
    }
}

extension PageViewControllerSegmentedAdapter: UIPageViewControllerDelegate {
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = self.viewControllers.firstIndex(of: viewController),
            index > 0 else {
                return nil
        }
        return self.viewControllers[index-1]
    }
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard var index = self.viewControllers.firstIndex(of: viewController) else {
            return nil
        }
        index = index + 1
        if index == self.viewControllers.count {
            return nil
        }
        return self.viewControllers[index]
    }
}

extension PageViewControllerSegmentedAdapter: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        guard let viewControllers = pageViewController.viewControllers,
            let lastViewController = viewControllers.last,
              let index = self.viewControllers.firstIndex(of: lastViewController) else {
                return
        }
        
        if finished && completed {
            self.selectedIndex = index
        }
    }
}
extension PageViewControllerSegmentedAdapter: DDSegmentControlDelegate {
    func change(to index: Int) {
        if index > selectedIndex {
            let nextIndex = index
            for i in nextIndex...index {
                self.setViewController(atIndex: i, direction: .forward)
            }
        } else if index < selectedIndex {
            let previousIndex = index
            for i in (index...previousIndex).reversed() {
                self.setViewController(atIndex: i, direction: .reverse)
            }
        }
    }
    
    
    
}
