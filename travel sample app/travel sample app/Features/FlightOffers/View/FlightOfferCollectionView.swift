import SwiftUI

/// Display a collection of Flight Offers in a "pager" style.
struct FlightOfferCollectionView: View {
    @State private var selectedPage = 0
    let cardWidth: CGFloat = 300.0
    
    var offers: [FlightOffersViewModel.OfferViewModel]
    
    var body: some View {
        VStack {
            
            // Title
            Text("FLIGHT OFFERS")
                .font(.title)
                .bold()
                .padding()
            
            // Cards
            TabView(selection: $selectedPage) {

                ForEach(Array(offers.enumerated()), id: \.element.id) { index, item in
                    
                    FlightOfferCardView(offer: item)
                        .padding(.horizontal)
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            // Page indicators.
            HStack {
                
                ForEach(Array(offers.enumerated()), id: \.element.id) { index, _ in
                    Circle()
                        .fill(selectedPage == index ? Color.black : Color.gray)
                        .frame(width: 10, height: 10)
                        .padding(.horizontal, 2)
                        .onTapGesture {
                            print(index)
                            selectedPage = index
                        }
                }
            }
            .padding(.bottom, 20)
        }
    }
}

struct FlightOffersCollectionView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        FlightOfferCollectionView(offers: [
            FlightOffersViewModel.OfferViewModel(id: "01", citiesPath: "Prague -> New York", price: "$119", airportsPath: "PRG → JFK · 2 stops", extraInformation: "12 hours total · other info", imagePath: ""),
            FlightOffersViewModel.OfferViewModel(id: "01", citiesPath: "Prague -> New York", price: "$129", airportsPath: "PRG → JFK · 2 stops", extraInformation: "12 hours total · other info", imagePath: ""),
            FlightOffersViewModel.OfferViewModel(id: "01", citiesPath: "Prague -> New York", price: "$139", airportsPath: "PRG → JFK · 2 stops", extraInformation: "12 hours total · other info", imagePath: ""),
            FlightOffersViewModel.OfferViewModel(id: "01", citiesPath: "Prague -> New York", price: "$149", airportsPath: "PRG → JFK · 2 stops", extraInformation: "12 hours total · other info", imagePath: ""),
            FlightOffersViewModel.OfferViewModel(id: "01", citiesPath: "Prague -> New York", price: "$159", airportsPath: "PRG → JFK · 2 stops", extraInformation: "12 hours total · other info", imagePath: "")
        ])
    }
}
