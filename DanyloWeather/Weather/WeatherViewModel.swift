//
//  DanyloWeather
//
//  Created by Dan on 2024-11-14.
//
// Student name: Danylo Chystov
// Student ID: 991560947

import Foundation
import Combine

@MainActor  //stating that all functionality here is performed on a main thread
class WeatherViewModel: ObservableObject{
    
    //initializing oublished vars to update ui
    @Published var location: String = "Fetching Weather"
    @Published var temperature: String = "--"
    @Published var windSpeed: String = "--"
    @Published var windDirection: String = "--"
    @Published var humidity: String = "--"
    @Published var feelsLike: String = "--"
    @Published var visibility: String = "--"
    @Published var uvIndex: String = "--"
    @Published var errorMsg: String?
    
    
    //inintializing needed managers
    private let locationManager = LocationManager()
    private let weatherManager = WeatherManager()
    
    //handling subscribers and subscription streams (needed with combine framework )
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        //running this function when viewModel is created to start location listenning and weather updating
        checkLocationUpdate()
    }
    
    
    //function to trigger Weather API call on location change
    private func checkLocationUpdate(){
        
        locationManager.$locationError
            .sink{ [weak self] error in
                if let error = error{
                    self?.errorMsg = error
                }
            }
            .store(in: &cancellables)
        
        
        
        locationManager.$latitude
            .combineLatest(locationManager.$longitude)   //combining the streams of updates of lat and long into one, emmits tuple on each update of either of these values
            .sink{ [weak self] latitude, longitude in      //subscribing to stream of updates running task on each update of the values in tuple
                guard let self = self,                      //check if all needed properties are non nil
                      let latitude = latitude,
                      let longitude = longitude else { return }
                Task{
                    await self.fetchWeather(latitude: latitude, longitude: longitude)   //asyncronously calling fetchWeather to avoid blocking main thread
                }
            }
            .store(in: &cancellables)       //handles subscription, cancelling the subscription when WeatherViewModel is deallocated
    }
    
    //function handling fetch weather call
    private func fetchWeather(latitude: Double, longitude: Double) async {
        do{
            if let weather = try await weatherManager.fetchWeather(latitude: latitude, longitude: longitude) {
                self.updateValues(with: weather)
            }
        } catch{
            errorMsg = "Failed to Fetch Weather Data"
            print("Error fetching weather: \(error.localizedDescription)")
        }
    }
    
    //updating published properties to reflect changes in Content View
    private func updateValues(with weather: WeatherResponce){
        location = "\(weather.location.name), \(weather.location.region), \(weather.location.country)"
        temperature = "\(weather.current.temp_c)°C"
        windSpeed = "\(weather.current.wind_kph) km/h"
        windDirection = weather.current.wind_dir
        humidity = "\(weather.current.humidity)%"
        feelsLike = "\(weather.current.feelslike_c)°C"
        visibility = "\(weather.current.vis_km) km"
        uvIndex = "\(weather.current.uv)"
        errorMsg = nil
    }

    
}
