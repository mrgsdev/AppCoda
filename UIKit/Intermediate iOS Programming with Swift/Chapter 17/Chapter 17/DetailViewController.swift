//
//  DetailViewController.swift
//  Chapter 17
//
//  Created by mrgsdev on 05.05.2024.
//
 
import UIKit
import WebKit
class DetailViewController: UIViewController {
    
    @IBOutlet var webView: WKWebView!
    @IBOutlet var actionButtonItem: UIBarButtonItem!
    var filename = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the full path of the file
        if let fileURL = fileToURL(file: filename) {
            let urlRequest = URLRequest(url: fileURL)
            webView.load(urlRequest)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fileToURL(file: String) -> URL? {
        // Get the full path of the file
        let fileComponents = file.components(separatedBy: ".")
        
        if let filePath = Bundle.main.path(forResource: fileComponents[0], ofType: fileComponents[1]) {
            return URL(fileURLWithPath: filePath)
        }
        
        return nil
    }
    @IBAction func share(sender: AnyObject) {
        if let fileURL = fileToURL(file: filename) {
            let objectsToShare = [fileURL]
            let activityController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            let activityTypeType = UIActivity.ActivityType.self
            let excludedActivities = [
                activityTypeType.postToFlickr,
                activityTypeType.postToWeibo,
                activityTypeType.message,
                activityTypeType.mail,
                activityTypeType.print,
                activityTypeType.copyToPasteboard,
                activityTypeType.assignToContact,
                activityTypeType.saveToCameraRoll,
                activityTypeType.addToReadingList,
                activityTypeType.postToFlickr,
                activityTypeType.postToVimeo,
                activityTypeType.postToTencentWeibo
            ]
            activityController.excludedActivityTypes = excludedActivities
            present(activityController, animated: true, completion: nil)
            if let popOverController = activityController.popoverPresentationController { popOverController.barButtonItem = actionButtonItem
            }
        }
    }
}
