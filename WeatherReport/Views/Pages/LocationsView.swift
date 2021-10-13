//
// Created by Halil Kaya on 7.10.2021.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    @ObservedObject var locationVM = LocationViewModel()
    
    var body: some View {
        //let coordinate = self.locationVM.lastLocation != nil ? self.locationVM.lastLocation!.coordinate : CLLocationCoordinate2D()
        let cityDetails = locationVM.cityDetails
        NavigationView {
            List (cityDetails) { details in
            //Text("\(coordinate.latitude),\(coordinate.longitude)")
                Text(details.title)
            }
        }
    }
}

struct RowView: View {
    var details: Coordinates
    
    var body: some View {
        Text(details.title)
        Text("Distance: \(details.distance)")
    }
}

