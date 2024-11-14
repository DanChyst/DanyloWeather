//
//  WeaterModel.swift
//  DanyloWeather
//
//  Created by Dan on 2024-11-14.
//

import Foundation

struct WeatherResponce: Codable {
    let location: Location
    let current: CurrentWeather
}

struct Location: Codable {
    let name: String
    let region: String
    let country: String
}

struct CurrentWeather: Codable {
    let temperature: Double
    let windSpeed: Double
    let windDirection: String
    let humidity: Int
    let feelsLike: Double
    let visibility: Double
    let uvIndex: Double
    
    private enum CodingKeys: String, CodingKey {
        case temperature = "temp_c"
        case windSpeed = "wind_kmh"
        case windDirection = "wind_dir"
        case humidity
        case feelsLike = "feelslike_c"
        case visibility = "vis_km"
        case uvIndex = "uv"
    }
}
