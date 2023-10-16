import SwiftUI

// A view of Single flight offer in a "Card" format.
struct FlightOfferView: View {
    
    var body: some View {
        
        VStack {
            
            VStack {
                Image("placeholder")
                    .resizable()
                    .clipped()
                    .background(Color.gray.opacity(0.1))
                
                Spacer()
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Prague → New York")
                            .font(.title2)
                            .bold()
                        Spacer()
                        Text("$199")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(Color.green)
                    }
                    .padding(.horizontal)
                    
                    
                    Text("PRG → JFK · 2 stops")
                        .padding(.horizontal)
                    Text("12 hours total · other info")
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
        FlightOfferView()
    }
}
