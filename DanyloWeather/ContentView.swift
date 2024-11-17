//
//  ContentView.swift
//  DanyloWeather
//
//  Created by Dan on 2024-11-14.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WeatherViewModel()
   
    var body: some View {
        VStack {
            Text(viewModel.location)
                .font(.headline)
                .padding()
            
        }
        .padding()
        
        VStack(alignment: .leading, spacing: 8) {
            Text("Temperature: \(viewModel.temperature)")
            Text("Wind: \(viewModel.windSpeed) (\(viewModel.windDirection))")
            Text("Humidity: \(viewModel.humidity)")
            Text("Feels Like: \(viewModel.feelsLike)")
            Text("Visibility: \(viewModel.visibility)")
            Text("UV Index: \(viewModel.uvIndex)")
        }
        .padding()
        
        if viewModel.errorMsg != ""{
            Text(viewModel.errorMsg)
                .foregroundStyle(.red)
                .padding()
        }
    }
}

#Preview {
    ContentView()
}
