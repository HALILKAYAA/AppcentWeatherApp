//
// Created by Halil Kaya on 7.10.2021.
//

import SwiftUI

struct TodayWeather: View {
    @ObservedObject var cityViewModel: CityViewModel

    var body: some View {
        VStack(spacing: 10) {
            Text("Today")
                    .font(.largeTitle)
                    .bold()

            HStack(spacing: 20) {
                LottieView(name: cityViewModel.getLottieAnimationFor(icon: cityViewModel.today.icon))
                .frame(width: 90, height: 90)

                VStack(alignment: .leading) {
                    Text("\(cityViewModel.temperature)℃")
                            .font(.system(size: 42))
                    Text(cityViewModel.conditions)
                }
            }
            HStack {
                Spacer()
                widgetView(image: "wind", color: .gray, title: "\(cityViewModel.windSpeed) km/hr")
                Spacer()
                widgetView(image: "drop.fill", color: .blue, title: "\(cityViewModel.humidity)")
                Spacer()
                widgetView(image: "eyes", color: .green, title: "\(cityViewModel.predictability)")
                Spacer()
            }
        }
                .padding()
                .foregroundColor(.white)
                .background(
                        RoundedRectangle(cornerRadius: 20)
                                .fill(LinearGradient(
                                        gradient: Gradient(colors: [Color.green.opacity(0.5), Color.green]),
                                        startPoint: .top,
                                        endPoint: .bottom))
                                .opacity(0.3)
                )
                .shadow(color: Color.white.opacity(0.1), radius: 2, x: -2, y: -2)
                .shadow(color: Color.black.opacity(0.2), radius: 2, x: 2, y: 2)
    }

    private func widgetView(image: String, color: Color, title: String) -> some View {
        VStack {
            Image(systemName: image)
                    .padding()
                    .font(.title)
                    .foregroundColor(color)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))

            Text(title)
        }
    }
}

struct TodayWeather_Previews: PreviewProvider {
    static var previews: some View {
        TodayWeather(cityViewModel: CityViewModel())
    }
}
