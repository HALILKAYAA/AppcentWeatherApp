//
// Created by Halil Kaya on 7.10.2021.
//

import SwiftUI

struct CityNameView: View {
    var city: Location
    var date: String

    var body: some View {
        HStack {
            VStack(alignment: .center, spacing: 10){
                Text("\(city.title)")
                        .font(.title)
                        .bold()
                Text("\(city.locationType). \(date)")
            }.foregroundColor(.white)
        }
    }
}

struct CityNameView_Previews: PreviewProvider {
    static var previews: some View {
        CityNameView(city: Location(), date: "01/01/2013")
    }
}
