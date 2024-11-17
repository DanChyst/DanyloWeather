//
//  WeaterModel.swift
//  DanyloWeather
//
//  Created by Dan on 2024-11-14.
//
// Student name: Danylo Chystov
// Student ID: 991560947

import Foundation

//weather responce model to store data received with api responce
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
    let temp_c: Double
    let wind_kph: Double
    let wind_dir: String
    let humidity: Int
    let feelslike_c: Double
    let vis_km: Double
    let uv: Double
}
