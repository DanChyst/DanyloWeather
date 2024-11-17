//
//  DanyloWeather
//
//  Created by Dan on 2024-11-14.
//
// Student name: Danylo Chystov
// Student ID: 991560947

import Foundation
import CoreLocation     //importing CoreLocation to use Location Services
import Combine          //used to handle published values and value observation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate{
    private let locationManager = CLLocationManager()
    
    //inititalizing Combine publishers
    @Published var latitude: Double?
    @Published var longitude: Double?
    
    //overrriding initializer to implement all needed properties and start functions for location etc..
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
