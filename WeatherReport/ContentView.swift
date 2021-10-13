//
//  Created by Halil Kaya on 7.10.2021.
//

import SwiftUI
import Firebase

struct ContentView: View {
    init() {
        FirebaseApp.configure()
    }
    
    @ObservedObject var viewModel = CityViewModel()
    
    var body: some View {
        
        TabView{
            ZStack {
                VStack(spacing: 0) {
                    MenuHeader(cityViewModel: viewModel)
                        .padding(.horizontal, 10)
                    ScrollView(showsIndicators: false) {
                        PredictionBoard(cityViewModel: viewModel)
                    }.padding(.top, 10)
                }.padding(.top, 40)
            }.tabItem {
                Image(systemName: "cloud.sun.fill")
            }
            .background(
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)), Color(#colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .edgesIgnoringSafeArea(.all)
            LocationsView()
                .tabItem {
                    Image(systemName: "location")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

