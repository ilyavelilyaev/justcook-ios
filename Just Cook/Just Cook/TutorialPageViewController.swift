//
//  TutorialViewController.swift
//  Just Cook
//
//  Created by Ilya Velilyaev on 18.03.16.
//  Copyright © 2016 Ilya Velilyaev. All rights reserved.
//

import UIKit

class TutorialPageViewController: UIPageViewController {

    var orderedViewControllers = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        orderedViewControllers.append(TutFirstViewController())
        orderedViewControllers.append(TutSecondViewController())
        orderedViewControllers.append(TutFirstViewController())
        orderedViewControllers.append(TutSecondViewController())
        setViewControllers([orderedViewControllers.first!], direction: .Forward, animated: true, completion: nil)
    }

    override func updateViewConstraints() {
        self.view.snp_updateConstraints { (make) -> Void in
            make.centerX.equalTo(parentViewController!.view)
            make.centerY.equalTo(parentViewController!.view).multipliedBy(0.9)
            make.width.height.equalTo(parentViewController!.view).multipliedBy(0.7)
        }
        super.updateViewConstraints()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

}

extension TutorialPageViewController: UIPageViewControllerDataSource {
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.indexOf(viewController) else {
            return nil
        }
        
        guard viewControllerIndex - 1 >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > viewControllerIndex - 1 else {
            return nil
        }
        
        return orderedViewControllers[viewControllerIndex - 1]
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.indexOf(viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        if nextIndex == orderedViewControllersCount {
            NSNotificationCenter.defaultCenter().postNotificationName("lastPageIsOpened", object: nil)
        }
        
        guard nextIndex < orderedViewControllersCount else {
            return nil
        }
        
        
        return orderedViewControllers[nextIndex]
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            firstViewControllerIndex = orderedViewControllers.indexOf(firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
    }
}