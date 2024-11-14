//
//  WeatherViewModel.swift
//  DanyloWeather
//
//  Created by Dan on 2024-11-14.
//

import Foundation
import Combine

class WeatherViewModel: ObservableObject{
    @Published var location: String = "Fetching Weather"
    @Published var temperature: String = "--"
    @Published var windSpeed: String = "--"
    @Published var windDirection: String = "--"
    @Published var humidity: String = "--"
    @Published var feelsLike: String = "--"
    @Published var visibility: String = "--"
    @Published var uvIndex: String = "--"
    @Published var errorMsg: String = "--"
    
    private let locationManager = LocationManager()
    private let weatherManager = WeatherManager()
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        checkLocationUpdate()
    }
    
    
    //function to trigger Weather API call on location change
    private func checkLocationUpdate(){
        locationManager.$latitude
            .combineLatest(locationManager.$longitude)
            .sink{ [weak self] latitude, longitude in
                guard let self = self,
                      let latitude = latitude,
                      let longitude = longitude else { return }
                Task{
                    await self.fetchWeather(latitude: latitude, longitude: longitude)
                }
            }
            .store(in: &cancellables)
    }
    
    
    private func fetchWeather(latitude: Double, longitude: Double) async {
        do{
            if let weather = try await weatherManager.fetchWeather(latitude: latitude, longitude: longitude) {
                DispatchQueue.main.async {
                    self.updateValues(with: weather)
                }
            }
        } catch{
            errorMsg = "Failed to Fetch Weather Data"
            print("Error fetching weather: \(error.localizedDescription)")
        }
    }
    
    private func updateValues(with weather: WeatherResponce){
        location = "\(weather.location.name), \(weather.location.region), \(weather.location.country)"
        temperature = "\(weather.current.temperature)°C"
        windSpeed = "\(weather.current.windSpeed) km/h"
        windDirection = weather.current.windDirection
        humidity = "\(weather.current.humidity)%"
        feelsLike = "\(weather.current.feelsLike)°C"
        visibility = "\(weather.current.visibility) km"
        uvIndex = "\(weather.current.uvIndex)"
        errorMsg = ""
    }

    
}
