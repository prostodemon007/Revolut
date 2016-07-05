//
//  IGGInfinitePageViewController.swift
//  IGGInfinitePageViewController
//
//  Created by Anak Mirasing on 6/12/2559 BE.
//  Copyright © 2559 iGROOMGRiM. All rights reserved.
//

import UIKit

public protocol InfinitePageViewDelegate: class {
    func pageViewController(vc : InfinitePageViewController, currentIndex: Int)
}

public class InfinitePageViewController: UIPageViewController {
    private var controllers: [UIViewController]
    public weak var infiniteDelegate: InfinitePageViewDelegate?
    
    public init(viewControllers: [UIViewController]) {
        controllers = viewControllers
        super.init(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        guard let firstViewController = controllers.first else {
            return
        }
        
        setViewControllers([firstViewController], direction: .Forward, animated: true, completion: nil)
    }
}

extension InfinitePageViewController: UIPageViewControllerDataSource {
    public func pageViewController(pageViewController: UIPageViewController,
                            viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.indexOf(viewController) else {
            return nil
        }
        
        
        infiniteDelegate?.pageViewController(self, currentIndex: index)
        
        if index == 0 {
            return controllers[controllers.count-1]
        }
        
        let previousIndex = index - 1
        return controllers[previousIndex]
    }
    
    public func pageViewController(pageViewController: UIPageViewController,
                            viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.indexOf(viewController) else {
            return nil
        }
        
        infiniteDelegate?.pageViewController(self, currentIndex: index)
        
        let nextIndex = index + 1
        if nextIndex == controllers.count {
            
            return controllers.first
        }
        
        return controllers[nextIndex]
    }
}
