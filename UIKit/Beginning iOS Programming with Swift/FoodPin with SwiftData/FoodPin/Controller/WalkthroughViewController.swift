//
//  WalkthroughViewController.swift
//  FoodPin
//
//  Created by mrgsdev on 15.04.2024.
//

import UIKit
class WalkthroughViewController: UIViewController {
    
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var nextButton: UIButton! {
        didSet {
            nextButton.layer.cornerRadius = 25.0
            nextButton.layer.masksToBounds = true
        }
    }
    @IBOutlet var skipButton: UIButton!
    
    var walkthroughPageViewController: WalkthroughPageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        if let pageViewController = destination as? WalkthroughPageViewController {
            walkthroughPageViewController = pageViewController
            walkthroughPageViewController?.walkthroughDelegate = self
        }
    }
    
    @IBAction func skipButtonTapped(sender: UIButton) {
        createQuickActions()

        UserDefaults.standard.set(true, forKey: "hasViewedWalkthrough")
 
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextButtonTapped(sender: UIButton) {
        
        if let index = walkthroughPageViewController?.currentIndex {
            switch index {
            case 0...1:
                walkthroughPageViewController?.forwardPage()
                
            case 2:
                createQuickActions()

                UserDefaults.standard.set(true, forKey: "hasViewedWalkthrough")
                dismiss(animated: true, completion: nil)
                
            default: break
                
            }
        }
        
        updateUI()
    }
    
    func updateUI() {
        
        if let index = walkthroughPageViewController?.currentIndex {
            switch index {
            case 0...1:
                nextButton.setTitle(String(localized: "NEXT"), for: .normal)
                skipButton.isHidden = false
            case 2:
                nextButton.setTitle(String(localized: "GET STARTED"), for: .normal)
                skipButton.isHidden = true
            default: break
            }
            
            pageControl.currentPage = index
        }
        
    }
    
    func createQuickActions()  {
        if let bundleIdentifier = Bundle.main.bundleIdentifier {
            let shortcutItem1 = UIApplicationShortcutItem(
                type: "\(bundleIdentifier).OpenFavorites",
                localizedTitle: "Show Favorites",
                localizedSubtitle: nil,
                icon: UIApplicationShortcutIcon(systemImageName: "tag"),
                userInfo:nil
            )
            let shortcutItem2 = UIApplicationShortcutItem(
                type: "\(bundleIdentifier).OpenDiscover",
                localizedTitle: "Discover Restaurants",
                localizedSubtitle: nil,
                icon: UIApplicationShortcutIcon(systemImageName: "eyes"),
                userInfo: nil
            )
            let shortcutItem3 = UIApplicationShortcutItem(
                type: "\(bundleIdentifier).NewRestaurant", 
                localizedTitle: "New Restaurant", localizedSubtitle: nil,
                icon: UIApplicationShortcutIcon(type: .add),
                userInfo: nil
            )
            UIApplication.shared.shortcutItems = [shortcutItem1, shortcutItem2, shortcutItem3]
        }
    }
}

extension WalkthroughViewController: WalkthroughPageViewControllerDelegate {
    
    func didUpdatePageIndex(currentIndex: Int) {
        updateUI()
    }
    
}
