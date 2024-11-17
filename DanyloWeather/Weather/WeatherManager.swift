//
//  WeatherService.swift
//  DanyloWeather
//
//  Created by Dan on 2024-11-14.
//

import Foundation

//class handling api call, url creation and error handling related only to api calls 
class WeatherManager{
    
    //handling api key and base url
    private let apiKey = "413457d25a954bd2b9981635241411"
    private let baseUrl = "https://api.weatherapi.com/v1/current.json"
    
    //fetching weather
    func fetchWeather(latitude: Double, longitude: Double) async throws -> WeatherResponce? {
        
        //composing url string
        let urlStr = baseUrl + "?key=" + apiKey + "&q=\(latitude), \(longitude)&aqi=no"
        
        //creating actual url
        guard let url = URL(string: urlStr) else { return nil }
        
        do {
            
            //getting data from api responce
            let(data, _) = try await URLSession.shared.data(from: url)
            
//used for debugging
//            if let jsonString = String(data: data, encoding: .utf8) {
//                print("API Response: \(jsonString)")
//            }
            
            let decoder = JSONDecoder()
            
            //decoding api responce / storing needed data
            let weatherResponse = try decoder.decode(WeatherResponce.self, from: data)
            return weatherResponse
        }catch{
            
            //handling errors
            print("Error while fetching or decoding data \(error.localizedDescription)")
            throw error
        }
    }
}
