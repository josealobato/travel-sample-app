import SwiftUI

/// Display a collection of Flight Offers in a "pager" style.
struct FlightOffersCollectionView: View {
    @State private var selectedPage = 0
    let pageCount = 5
    let cardWidth: CGFloat = 300.0
    
    var body: some View {
        VStack {
            
            // Title
            Text("FLIGHT OFFERS")
                .font(.title)
                .bold()
                .padding()
            
            // Cards
            TabView(selection: $selectedPage) {

                ForEach(0..<pageCount) { index in
                    FlightOfferView()
                        .padding(.horizontal)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            // Page indicators.
            HStack {
                ForEach(0..<pageCount) { index in
                    Circle()
                        .fill(selectedPage == index ? Color.black : Color.gray)
                        .frame(width: 10, height: 10)
                        .padding(.horizontal, 2)
                }
            }
            .padding(.bottom, 20)
        }
    }
}

struct FlightOffersCollectionView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        FlightOffersCollectionView()
    }
}
