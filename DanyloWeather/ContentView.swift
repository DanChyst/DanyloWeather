//  DanyloWeather
//
//  Created by Dan on 2024-11-14.
//
// Student name: Danylo Chystov
// Student ID: 991560947

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WeatherViewModel()
   
    var body: some View {
        Text("Weather App")
            .font(.title)
            .bold()
            .padding(.top, 50)
        Spacer()
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
        
        if let errorMessage = viewModel.errorMsg {
            Text(errorMessage)
                .foregroundStyle(.red)
                .padding()
        }
        Spacer()
    }

}

#Preview {
    ContentView()
}
