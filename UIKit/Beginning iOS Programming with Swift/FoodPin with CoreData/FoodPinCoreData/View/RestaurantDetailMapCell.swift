//
//  RestaurantDetailMapCell.swift
//  FoodPinCoreData
//
//  Created by mrgsdev on 03.05.2024.
//

import UIKit
import MapKit
class RestaurantDetailMapCell: UITableViewCell {
    
    @IBOutlet var mapView:MKMapView!{
        didSet{
            mapView.layer.cornerRadius = 20
            mapView.clipsToBounds = true
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureMapInCell(location: String) {
        // Get location
        let geoCoder = CLGeocoder()
        print("restaurant location: \(location)")
        geoCoder.geocodeAddressString(location, completionHandler: { placemarks, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let placemarks = placemarks {
                // Get the first placemark
                let placemark = placemarks[0]
                // Add annotation
                let annotation = MKPointAnnotation()
                if let location = placemark.location {
                    // Display the annotation
                    annotation.coordinate = location.coordinate
                    self.mapView.addAnnotation(annotation)
                    // Set the zoom level
                    let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 250, longitudinalMeters: 250)
                    self.mapView.setRegion(region, animated: false)
                }
            }
        })
        
    }
    
}

