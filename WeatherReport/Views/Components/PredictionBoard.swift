//
// Created by Halil Kaya on 7.10.2021.
//

import Foundation

import SwiftUI

struct PredictionBoard: View {
    @ObservedObject var cityViewModel: CityViewModel

    var body: some View {
        VStack {
            CityNameView(city: cityViewModel.location, date: cityViewModel.date)
                    .shadow(radius: 0)
            TodayWeather(cityViewModel: cityViewModel)
                    .padding()
            DailyWeather(cityViewModel: cityViewModel)
                    .padding(.horizontal)
        }.padding(.bottom, 30)
    }
}

struct City_Previews: PreviewProvider {
    static var previews: some View {
        PredictionBoard(cityViewModel: CityViewModel())
    }
}
