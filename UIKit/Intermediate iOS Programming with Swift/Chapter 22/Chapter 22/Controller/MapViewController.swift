//
//  MapViewController.swift
//  Chapter 22
//
//  Created by mrgsdev on 11.05.2024.
//

import UIKit

class MapViewController: UIViewController {
    
    @IBOutlet var menuButton:UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addSideBarMenu(leftMenuButton: menuButton)
    }

}
