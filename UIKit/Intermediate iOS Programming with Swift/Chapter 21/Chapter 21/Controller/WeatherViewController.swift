//
//  WeatherViewController.swift
//  Chapter 21
//
//  Created by mrgsdev on 10.05.2024.
//

import UIKit
import WeatherInfoKit

class WeatherViewController: UIViewController {

    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var weatherLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    
    var city = "Paris"
    var country = "France"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        weatherLabel.text = ""
        temperatureLabel.text = ""
        
        displayCurrentWeather()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func displayCurrentWeather() {
        // Update location
        cityLabel.text = city
        countryLabel.text = country
        
        // Invoke weather service to get the weather data
        WeatherService.sharedWeatherService().getCurrentWeather(location: city, completion: { (data) -> () in
            OperationQueue.main.addOperation({ () -> Void in
                if let weatherData = data {
                    self.weatherLabel.text = weatherData.weather.capitalized
                    self.temperatureLabel.text = String(format: "%d", weatherData.temperature) + "\u{00B0}"
                }
            })
        })
    }

    // MARK: - Action methods
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
    }
    
    @IBAction func updateWeatherInfo(segue: UIStoryboardSegue) {
        let sourceViewController = segue.source as! LocationTableViewController
        
        city = sourceViewController.selectedCity
        country = sourceViewController.selectedCountry
        
        displayCurrentWeather()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "showLocations" {
            let destinationController = segue.destination as! UINavigationController
            let locationTableViewController = destinationController.viewControllers[0] as! LocationTableViewController
            locationTableViewController.selectedLocation = "\(city), \(country)"
        }
    }
    

}
