//
//  ViewController.swift
//  Weather
//
//  Created by  Arthur Bodrov on 16/03/2019.
//  Copyright © 2019  Arthur Bodrov. All rights reserved.
//

import UIKit
import CoreLocation


class MainViewController: UIViewController, CLLocationManagerDelegate {

    // Outlets
    
        // First (high) View
    @IBOutlet var bgView: UIView!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
        // Second (low) View
    
            // First pak forecast weather
    @IBOutlet weak var timeFirst: UILabel!
    @IBOutlet weak var miniImageFirst: UIImageView!
    @IBOutlet weak var tempFirst: UILabel!
    
            // Second pak forecast weather
    @IBOutlet weak var timeSecond: UILabel!
    @IBOutlet weak var miniImageSecond: UIImageView!
    @IBOutlet weak var tempSecond: UILabel!
    
            // Third pak forecast weather
    @IBOutlet weak var timeThird: UILabel!
    @IBOutlet weak var miniImageThird: UIImageView!
    @IBOutlet weak var tempThird: UILabel!
    
           // Fourth pak forecast weather
    @IBOutlet weak var timeFourth: UILabel!
    @IBOutlet weak var miniImageFouth: UIImageView!
    @IBOutlet weak var tempFourth: UILabel!
    
    // Buttons 
    @IBOutlet weak var todayButton: UIButton!
    
    
    // View under button
    @IBOutlet weak var viewUnderTodayButton: UIView!

    
    //Actions
    @IBAction func tappedTodayButton(_ sender: UIButton) {
    }
    
   
    
    // Constains
    let locationManager = CLLocationManager()
    
    
    
    // Variables
    var currentLocation: CLLocation!
    var currentWeather: CurrentTodayWeather!
    var futureWeather: FutureTodayWeather!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocation()
        callDelegates()
        currentWeather = CurrentTodayWeather()
        futureWeather = FutureTodayWeather()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        locationAuthCheck()
    }
    
    //MARK: - Location
    
    func callDelegates(){
        locationManager.delegate = self
    }
    
    func setupLocation(){
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
    }
    
    func locationAuthCheck(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            // Get the location from device
//            guard locationManager.location != nil else { return print("Location is nil, you need configure location, go to Simulator -> Top menu -> 'Debug' -> 'Location'") }
            currentLocation = locationManager.location
            // Pass the location coordinate to our API
            print(currentLocation.coordinate.latitude)
            print(currentLocation.coordinate.longitude)

            Location.sharedIntance.longitude = currentLocation.coordinate.longitude
            Location.sharedIntance.latitude = currentLocation.coordinate.latitude

            // Download the API Data
            currentWeather.downloadCurrentWeather {
                // Update high UI after download
                self.updateHighUI()
            }
            futureWeather.downloadFutureWeather {
                // Update low UI after download
                self.updateLowUI()
            }
            
            
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthCheck()
        }
    }
    
    
    enum Icon{
        
        case clearSky
        case fewClouds
        case scatteredClouds
        case brokenClouds
        case showerRain
        case rain
        case thunderstorm
        case snow
        case mist
        
    }
    
    // MARK: - Update UI
    

    func updateHighUI() {
        cityLabel.text = currentWeather.cityName
        tempLabel.text = "\(Int(currentWeather.currentTemp))˚"
        weatherType.text = currentWeather.weatherType
        
        // TODO: change color when type weather is changing
        print(currentWeather.weatherDescription)
        
       
        switch currentWeather.weatherDescription {
        case "clear sky":
            weatherImage.image = UIImage(named: "clear-sky")

        case "few clouds":
            weatherImage.image = UIImage(named: "few-clouds")
            bgView.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)

        case "scattered clouds":
            weatherImage.image = UIImage(named: "scattered-clouds")
            bgView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)

        case "broken clouds":
            weatherImage.image = UIImage(named: "broken-clouds")
            bgView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)

        case "shower rain":
            weatherImage.image = UIImage(named: "shower-rain")
            bgView.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)

        case "rain":
            weatherImage.image = UIImage(named: "rain")
            bgView.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)

        case "thunderstorm":
            weatherImage.image = UIImage(named: "thunderstorm")
            bgView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)

        case "snow":
            weatherImage.image = UIImage(named: "snow")
            bgView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)

        case "mist":
            weatherImage.image = UIImage(named: "mist")
            bgView.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            
        case "overcast clouds":
            weatherImage.image = UIImage(named: "few-clouds")
            bgView.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            
        default:
            weatherImage.image = UIImage(named: "clear-sky")
            print("defaulf image case")
        }
    }
    
    func updateLowUI() {
        tempFirst.text = "\(Int(futureWeather.firstTemp))˚"
        timeFirst.text = futureWeather.firstTime
        let firstWeatherType = futureWeather.firstWeatherType
        
        tempSecond.text = "\(Int(futureWeather.secondTemp))˚"
        timeSecond.text = futureWeather.secondTime
        let secondWeatherType = futureWeather.secondWeatherType
        
        tempThird.text = "\(Int(futureWeather.thirdTemp))˚"
        timeThird.text = futureWeather.thirdTime
        let thirdWeatherType = futureWeather.thirdWeatherType
        
        tempFourth.text = "\(Int(futureWeather.fourthTemp))˚"
        timeFourth.text = futureWeather.fourthTime
        let fourthWeatherType = futureWeather.fourthWeatherType
        
//        print(firstWeatherType)
        switch firstWeatherType {
            
        case "Clear":
            miniImageFirst.image = UIImage(named: "clear-sky")
            
        case "Few clouds":
            miniImageFirst.image = UIImage(named: "few-clouds")
            
        case "Scattered clouds":
            miniImageFirst.image = UIImage(named: "scattered-clouds")
            
        case "Broken clouds":
            miniImageFirst.image = UIImage(named: "broken-clouds")
            
        case "Shower rain":
            miniImageFirst.image = UIImage(named: "shower-rain")
            
        case "Rain":
            miniImageFirst.image = UIImage(named: "rain")
            
        case "Thunderstorm":
            miniImageFirst.image = UIImage(named: "thunderstorm")
            
        case "Snow":
            miniImageFirst.image = UIImage(named: "snow")
            
        case "Mist":
            miniImageFirst.image = UIImage(named: "mist")
            
        case "Overcast clouds":
            miniImageFirst.image = UIImage(named: "few-clouds")
            
        default:
            miniImageFirst.image = UIImage(named: "clear-sky")
            print("Mini first image - defaulf image case")
        }
        
//        print(secondWeatherType)
        switch secondWeatherType {
            
        case "Clear":
            miniImageSecond.image = UIImage(named: "clear-sky")
            
        case "Few clouds":
            miniImageSecond.image = UIImage(named: "few-clouds")
            
        case "Scattered clouds":
            miniImageSecond.image = UIImage(named: "scattered-clouds")
            
        case "Broken clouds":
            miniImageSecond.image = UIImage(named: "broken-clouds")
            
        case "Shower rain":
            miniImageSecond.image = UIImage(named: "shower-rain")
            
        case "Rain":
            miniImageSecond.image = UIImage(named: "rain")
            
        case "Thunderstorm":
            miniImageSecond.image = UIImage(named: "thunderstorm")
            
        case "Snow":
            miniImageSecond.image = UIImage(named: "snow")
            
        case "Mist":
            miniImageSecond.image = UIImage(named: "mist")
            
        case "Overcast clouds":
            miniImageSecond.image = UIImage(named: "few-clouds")
            
        default:
            miniImageSecond.image = UIImage(named: "clear-sky")
            print("Mini second image - defaulf image case")
        }
        
//        print(thirdWeatherType)
        switch thirdWeatherType {
            
        case "Clear":
            miniImageThird.image = UIImage(named: "clear-sky")
            
        case "Few clouds":
            miniImageThird.image = UIImage(named: "few-clouds")
            
        case "Scattered clouds":
            miniImageThird.image = UIImage(named: "scattered-clouds")
            
        case "Broken clouds":
            miniImageThird.image = UIImage(named: "broken-clouds")
            
        case "Shower rain":
            miniImageThird.image = UIImage(named: "shower-rain")
            
        case "Rain":
            miniImageThird.image = UIImage(named: "rain")
            
        case "Thunderstorm":
            miniImageThird.image = UIImage(named: "thunderstorm")
            
        case "Snow":
            miniImageThird.image = UIImage(named: "snow")
            
        case "Mist":
            miniImageThird.image = UIImage(named: "mist")
            
        case "Overcast clouds":
            miniImageThird.image = UIImage(named: "few-clouds")
            
        default:
            miniImageThird.image = UIImage(named: "clear-sky")
            print("Mini third image - defaulf image case")
        }
        
//        print(fourthWeatherType)
        switch fourthWeatherType {
            
        case "Clear":
            miniImageFouth.image = UIImage(named: "clear-sky")
            
        case "Few clouds":
            miniImageFouth.image = UIImage(named: "few-clouds")
            
        case "Scattered clouds":
            miniImageFouth.image = UIImage(named: "scattered-clouds")
            
        case "Broken clouds":
            miniImageFouth.image = UIImage(named: "broken-clouds")
            
        case "Shower rain":
            miniImageFouth.image = UIImage(named: "shower-rain")
            
        case "Rain":
            miniImageFouth.image = UIImage(named: "rain")
            
        case "Thunderstorm":
            miniImageFouth.image = UIImage(named: "thunderstorm")
            
        case "Snow":
            miniImageFouth.image = UIImage(named: "snow")
            
        case "Mist":
            miniImageFouth.image = UIImage(named: "mist")
            
        case "Overcast clouds":
            miniImageFouth.image = UIImage(named: "few-clouds")
            
        default:
            miniImageFouth.image = UIImage(named: "clear-sky")
            print("Mini fourth image - defaulf image case")
        }
    }

}

