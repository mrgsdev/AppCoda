//
//  NewsTableViewController.swift
//  Chapter 15
//
//  Created by mrgsdev on 02.05.2024.
//

import UIKit
import GoogleMobileAds

class NewsTableViewController: UITableViewController {

    lazy var adBannerView: GADBannerView = {
        let adBannerView = GADBannerView(adSize: GADPortraitAnchoredAdaptiveBannerAdSizeWithWidth(300))
        adBannerView.adUnitID = "ca-app-pub-8501671653071605/1166331146"
        adBannerView.delegate = self
        adBannerView.rootViewController = self
        
        return adBannerView
    }()
    
    var interstitial: GADInterstitialAd?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        
        GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = [ GADSimulatorID ]
        adBannerView.load(GADRequest())
        
        loadInterstitialAd()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows
        return 4
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsTableViewCell
        
        // Configure the cell...
        if indexPath.row == 0 {
            cell.postImageView.image = UIImage(named: "red-lights-lisbon")
            cell.postTitle.text = "Red Lights, Lisbon"
            cell.postAuthor.text = "TOM EVERSLEY (@tomeversley)"
            cell.authorImageView.image = UIImage(named: "appcoda-fav-logo")
            
        } else if indexPath.row == 1 {
            cell.postImageView.image = UIImage(named: "val-throrens-france")
            cell.postTitle.text = "Val Thorens, France"
            cell.postAuthor.text = "BARA ART (bara-art.com)"
            cell.authorImageView.image = UIImage(named: "appcoda-fav-logo")
            
        } else if indexPath.row == 2 {
            cell.postImageView.image = UIImage(named: "summer-beach-huts")
            cell.postTitle.text = "Summer Beach Huts, England"
            cell.postAuthor.text = "TOM EVERSLEY (@tomeversley)"
            cell.authorImageView.image = UIImage(named: "appcoda-fav-logo")
            
        } else {
            cell.postImageView.image = UIImage(named: "taxis-nyc")
            cell.postTitle.text = "Taxis, NYC"
            cell.postAuthor.text = "TOM EVERSLEY (@tomeversley)"
            cell.authorImageView.image = UIImage(named: "appcoda-fav-logo")
            
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return adBannerView
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return adBannerView.frame.height
    }
    
    private func loadInterstitialAd() {
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID: "ca-app-pub-8501671653071605/5691915429", request: request) { ad, error in
            
            if error != nil { return }
                        
            self.interstitial = ad
            self.interstitial?.fullScreenContentDelegate = self
            self.interstitial?.present(fromRootViewController: self)
        }

    }
}

extension NewsTableViewController: GADBannerViewDelegate {
    
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("Banner loaded successfully")
        
        // Reposition the banner ad to create a slide down effect
        let translateTransform = CGAffineTransform(translationX: 0, y: -bannerView.bounds.size.height)
        bannerView.transform = translateTransform

        UIView.animate(withDuration: 0.5) {
            bannerView.transform = CGAffineTransform.identity
        }
    }
    
    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
        
        print("Fail to receive ads")
        print(error)
    }

}

extension NewsTableViewController: GADFullScreenContentDelegate {
    
    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Interstitial ad loaded successfully")
    }
    
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("Failed to receive interstitial ads")
    }
}
