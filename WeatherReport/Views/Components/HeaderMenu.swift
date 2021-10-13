//
// Created by Halil Kaya on 7.10.2021.
//

import SwiftUI

struct MenuHeader: View {

    @ObservedObject var cityViewModel: CityViewModel
    @State private var searchTerm = ""
    
    var body: some View {
        HStack {
            TextField("Enter location", text: $searchTerm)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
            Button {
                cityViewModel.city = searchTerm
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.green)
                Image(systemName: "magnifyingglass")
                }
            }
            .frame(width: 50, height: 50)
        }
        .foregroundColor(.white)
        .padding()
        .background(ZStack(alignment: .leading) {
            Image(systemName: "magnifyingglass")
                    .foregroundColor(.green)
                    .padding(.leading, 10)

            RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.5))
        })
    }
}

struct MenuHeader_Previews: PreviewProvider {
    static var previews: some View {
        MenuHeader(cityViewModel: CityViewModel())
    }
}
