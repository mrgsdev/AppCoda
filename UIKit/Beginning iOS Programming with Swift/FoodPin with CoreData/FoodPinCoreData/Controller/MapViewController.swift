//
//  MapViewController.swift
//  FoodPinCoreData
//
//  Created by mrgsdev on 03.05.2024.
//

import UIKit
import MapKit
class MapViewController: UIViewController {
    @IBOutlet var mapView: MKMapView!
    var restaurant = Restaurant()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFullMapAnnotation()
        mapView.delegate = self
        mapView.showsScale = true
        mapView.showsScale = true
        mapView.showsTraffic = true
        // Do any additional setup after loading the view.
    }
    
    func configureFullMapAnnotation(){
        // Convert address to coordinate and annotate it on map
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(restaurant.location, completionHandler: { placemarks, error in
            if let error = error {
                print(error)
                return
            }
            if let placemarks = placemarks {
                // Get the first placemark
                let placemark = placemarks[0]
                
                // Add annotation
                let annotation = MKPointAnnotation()
                annotation.title = self.restaurant.name
                annotation.subtitle = self.restaurant.type
                if let location = placemark.location {
                    annotation.coordinate = location.coordinate
                    // Display the annotation
                    self.mapView.showAnnotations([annotation], animated: true)
                    self.mapView.selectAnnotation(annotation, animated: true)
                }
            }
        })
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension MapViewController:MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyMarker"
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        
        var annotationView:MKMarkerAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        if  annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        annotationView?.markerTintColor = .orange
        annotationView?.glyphImage = UIImage(systemName: "fork.knife")
        return annotationView
        
        
    }
}
