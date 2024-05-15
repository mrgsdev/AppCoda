//
//  WebViewController.swift
//  FoodPinCoreData
//
//  Created by mrgsdev on 04.05.2024.
//

import UIKit
import WebKit
class WebViewController: UIViewController {
    @IBOutlet var webView: WKWebView!
    
    var targetURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: targetURL) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
}
