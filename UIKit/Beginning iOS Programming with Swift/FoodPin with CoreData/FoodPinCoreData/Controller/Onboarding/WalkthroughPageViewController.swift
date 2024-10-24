//
//  WalkthroughPageViewController.swift
//  FoodPinCoreData
//  Onboarding
//  Created by mrgsdev on 03.05.2024.
//

import UIKit
protocol WalkthroughPageViewControllerDelegate: AnyObject {
    func didUpdatePageIndex(currentIndex: Int)
}
class WalkthroughPageViewController: UIPageViewController {
    weak var walkthroughDelegate: WalkthroughPageViewControllerDelegate?
    var pageHeadings = [String(localized: "CREATE YOUR OWN FOOD GUIDE"),
                        String(localized: "SHOW YOU THE LOCATION"),
                        String(localized: "DISCOVER GREAT RESTAURANTS")
    ]
    var pageImages = ["onboarding-1",
                      "onboarding-2",
                      "onboarding-3"
    ]
    var pageSubHeadings = [String(localized: "Pin your favorite restaurants and create your own food guide"),
                           String(localized: "Search and locate your favourite restaurant on Maps"),
                           String(localized: "Find restaurants shared by your friends and other foodies")
    ]
    var currentIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        // Set the data source to itself
        dataSource = self
        // Create the first walkthrough screen
        if let startingViewController = contentViewController(at: 0) {
            setViewControllers([startingViewController], direction: .forward,animated: true, completion: nil)
        }
    }
    
    
    
}
extension WalkthroughPageViewController: UIPageViewControllerDataSource {
    func forwardPage() {
        currentIndex += 1
        if let nextViewController = contentViewController(at: currentIndex) {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    func contentViewController(at index: Int) -> WalkthroughContentViewController? {
        if index < 0 || index >= pageHeadings.count {
            return nil
        }
        // Create a new view controller and pass suitable data.
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        if let pageContentViewController = storyboard.instantiateViewController(withIdentifier: "WalkthroughContentViewController") as? WalkthroughContentViewController {
            pageContentViewController.imageFile = pageImages[index]
            pageContentViewController.heading = pageHeadings[index]
            pageContentViewController.subHeading = pageSubHeadings[index]
            pageContentViewController.index = index
            return pageContentViewController
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?{
        var index = (viewController as! WalkthroughContentViewController).index
        index -= 1
        return contentViewController(at: index)
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! WalkthroughContentViewController).index
        index += 1
        return contentViewController(at: index)
    }
    
    
    
}
extension WalkthroughPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let contentViewController = pageViewController.viewControllers?.first as? WalkthroughContentViewController {
                currentIndex = contentViewController.index
                walkthroughDelegate?.didUpdatePageIndex(currentIndex: contentViewController.index)
            }
        }
    }
}
