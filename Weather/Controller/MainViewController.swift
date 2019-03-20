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
            guard locationManager.location != nil else { return print("Location is nil") }
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
    
    // MARK: - Update UI
    

    func updateHighUI() {
        cityLabel.text = currentWeather.cityName
        tempLabel.text = "\(Int(currentWeather.currentTemp))˚"
        weatherType.text = currentWeather.weatherType
        
        // TODO: change color when type weather is changing
        weatherImage.image = UIImage(named: "scattered-clouds")
        print(currentWeather.weatherDescription)
        switch currentWeather.weatherDescription {
        case "clear sky":
            weatherImage.image = UIImage(named: "clear-sky.png")
            break
        case "few clouds":
            weatherImage.image = UIImage(named: "few-clouds")
            bgView.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            break
        case "scattered clouds":
            weatherImage.image = UIImage(named: "scattered-clouds.png")
            bgView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            break
        case "broken clouds":
            weatherImage.image = UIImage(named: "broken-clouds.png")
            bgView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            break
        case "shower rain":
            weatherImage.image = UIImage(named: "shower-rain.png")
            bgView.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
            break
        case "rain":
            weatherImage.image = UIImage(named: "rain.png")
            bgView.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
            break
        case "thunderstorm":
            weatherImage.image = UIImage(named: "thunderstorm.png")
            bgView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            break
        case "snow":
            weatherImage.image = UIImage(named: "snow.png")
            bgView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            break
        case "mist":
            weatherImage.image = UIImage(named: "mist.png")
            bgView.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            break
        default:
            weatherImage.image = UIImage(named: "clear-sky.png")
            print("image didn't load")
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
        
        switch futureWeather.firstWeatherType {
        case "clear sky":
            weatherImage.image = UIImage(named: "clear-sky.png")
            break
        case "few clouds":
            weatherImage.image = UIImage(named: "few-clouds.png")
            break
        case "scattered clouds":
            weatherImage.image = UIImage(named: "scattered-clouds.png")
            break
        case "broken clouds":
            weatherImage.image = UIImage(named: "broken-clouds.png")
            break
        case "shower rain":
            weatherImage.image = UIImage(named: "shower-rain.png")
            break
        case "rain":
            weatherImage.image = UIImage(named: "rain.png")
            break
        case "thunderstorm":
            weatherImage.image = UIImage(named: "thunderstorm.png")
            break
        case "snow":
            weatherImage.image = UIImage(named: "snow.png")
            break
        case "mist":
            weatherImage.image = UIImage(named: "mist.png")
            break
        default:
            weatherImage.image = UIImage(named: "clear-sky.png")
            break
        }
        switch futureWeather.secondWeatherType {
        case "clear sky":
            weatherImage.image = UIImage(named: "clear-sky.png")
            break
        case "few clouds":
            weatherImage.image = UIImage(named: "few-clouds.png")
            break
        case "scattered clouds":
            weatherImage.image = UIImage(named: "scattered-clouds.png")
            break
        case "broken clouds":
            weatherImage.image = UIImage(named: "broken-clouds.png")
            break
        case "shower rain":
            weatherImage.image = UIImage(named: "shower-rain.png")
            break
        case "rain":
            weatherImage.image = UIImage(named: "rain.png")
            break
        case "thunderstorm":
            weatherImage.image = UIImage(named: "thunderstorm.png")
            break
        case "snow":
            weatherImage.image = UIImage(named: "snow.png")
            break
        case "mist":
            weatherImage.image = UIImage(named: "mist.png")
            break
        default:
            weatherImage.image = UIImage(named: "clear-sky.png")
            break
        }
        switch futureWeather.thirdWeatherType {
        case "clear sky":
            weatherImage.image = UIImage(named: "clear-sky.png")
            break
        case "few clouds":
            weatherImage.image = UIImage(named: "few-clouds.png")
            break
        case "scattered clouds":
            weatherImage.image = UIImage(named: "scattered-clouds.png")
            break
        case "broken clouds":
            weatherImage.image = UIImage(named: "broken-clouds.png")
            break
        case "shower rain":
            weatherImage.image = UIImage(named: "shower-rain.png")
            break
        case "rain":
            weatherImage.image = UIImage(named: "rain.png")
            break
        case "thunderstorm":
            weatherImage.image = UIImage(named: "thunderstorm.png")
            break
        case "snow":
            weatherImage.image = UIImage(named: "snow.png")
            break
        case "mist":
            weatherImage.image = UIImage(named: "mist.png")
            break
        default:
            weatherImage.image = UIImage(named: "clear-sky.png")
            break
        }
        switch futureWeather.fourthWeatherType {
        case "clear sky":
            weatherImage.image = UIImage(named: "clear-sky.png")
            break
        case "few clouds":
            weatherImage.image = UIImage(named: "few-clouds.png")
            break
        case "scattered clouds":
            weatherImage.image = UIImage(named: "scattered-clouds.png")
            break
        case "broken clouds":
            weatherImage.image = UIImage(named: "broken-clouds.png")
            break
        case "shower rain":
            weatherImage.image = UIImage(named: "shower-rain.png")
            break
        case "rain":
            weatherImage.image = UIImage(named: "rain.png")
            break
        case "thunderstorm":
            weatherImage.image = UIImage(named: "thunderstorm.png")
            break
        case "snow":
            weatherImage.image = UIImage(named: "snow.png")
            break
        case "mist":
            weatherImage.image = UIImage(named: "mist.png")
            break
        default:
            weatherImage.image = UIImage(named: "clear-sky.png")
            break
        }
    }

}

