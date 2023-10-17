import SwiftUI

// A view of Single flight offer in a "Card" format.
struct FlightOfferCardView: View {
    
    var offer: FlightOffersViewModel.OfferViewModel
    
    var body: some View {
        
        VStack {
            
            VStack {
                
                AsyncImage(url: URL(string: offer.imagePath)) { image in
                    image
                        .resizable()
                        .clipped()
                        .background(Color.gray.opacity(0.1))
                } placeholder: {
                    ProgressView()
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text(offer.citiesPath)
                            .font(.title2)
                            .bold()
                        Spacer()
                        Text(offer.price)
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(Color.green)
                    }
                    .padding(.horizontal)
                    
                    
                    Text(offer.airportsPath)
                        .padding(.horizontal)
                    Text(offer.extraInformation)
                        .padding(.horizontal)
                        .padding(.bottom)
                }
                .padding(0)
                
            }
            .padding(0)
            
            .background(Color.white)
            .cornerRadius(25)
            .shadow(radius: 5)
        }
        .padding(.all)
        .background(Color.white)
    }
}

struct FlightOffersView_Previews: PreviewProvider {
    static var previews: some View {
        FlightOfferCardView(offer: FlightOffersViewModel.OfferViewModel(id: "01", citiesPath: "Prague -> New York", price: "$119", airportsPath: "PRG → JFK · 2 stops", extraInformation: "12 hours total · other info", imagePath: ""))
    }
}
