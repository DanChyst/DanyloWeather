//
//  LocationManager.swift
//  DanyloWeather
//
//  Created by Dan on 2024-11-14.
//

import Foundation
import CoreLocation     //importing CoreLocation to use Location Services
import Combine

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate{
    private let locationManager = CLLocationManager()
    
    @Published var latitude: Double?
    @Published var longitude: Double?
    
    //overrriding initializer to implement all needed functions etc..
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    //handling updating location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        guard let latestLocation = locations.last else {return}
        latitude = latestLocation.coordinate.latitude
        longitude = latestLocation.coordinate.longitude
    }
    
    //handling location error
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get location: \(error.localizedDescription)")
    }
    
}
