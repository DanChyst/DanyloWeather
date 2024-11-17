//
//  WeatherService.swift
//  DanyloWeather
//
//  Created by Dan on 2024-11-14.
//

import Foundation

class WeatherManager{
    
    private let apiKey = "413457d25a954bd2b9981635241411"
    private let baseUrl = "https://api.weatherapi.com/v1/current.json"
    
    func fetchWeather(latitude: Double, longitude: Double) async throws -> WeatherResponce? {
        let urlStr = baseUrl + "?key=" + apiKey + "&q=\(latitude), \(longitude)&aqi=no"
        guard let url = URL(string: urlStr) else { return nil }
        
        do {
            let(data, _) = try await URLSession.shared.data(from: url)
//used for debugging
//            if let jsonString = String(data: data, encoding: .utf8) {
//                print("API Response: \(jsonString)")
//            }
            let decoder = JSONDecoder()
            let weatherResponse = try decoder.decode(WeatherResponce.self, from: data)
            return weatherResponse
        }catch{
            print("Error while fetching or decoding data \(error.localizedDescription)")
            throw error
        }
    }
}
