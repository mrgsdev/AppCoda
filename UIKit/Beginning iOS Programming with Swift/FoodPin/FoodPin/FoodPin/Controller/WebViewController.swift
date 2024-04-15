//
//  WebViewController.swift
//  FoodPin
//
//  Created by mrgsdev on 15.04.2024.
//

import UIKit
import WebKit
class WebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    var targetURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = URL(string: targetURL) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
