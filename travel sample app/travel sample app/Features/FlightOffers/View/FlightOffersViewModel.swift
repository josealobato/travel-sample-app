import Foundation

struct FlightOffersViewModel {
    
    struct OfferViewModel: Identifiable, Equatable {
        
        let id: String
        
        let citiesPath: String
        let priceInDollars: String
        let airportsPath: String
        let extraInformation: String
    }
    
    let Offers: [OfferViewModel]
    
    static var empty: FlightOffersViewModel {
        FlightOffersViewModel(Offers: [])
    }
}

extension FlightOffersViewModel {
    
    static func build(from flights: [FlightOfferEntity]) -> FlightOffersViewModel {
  
        dummyViewModel
//        let offersViewModels = flights.map { flight in
//            OfferViewModel(id: flight.id)
//        }
//
//        return FlightOffersViewModel(Offers: offersViewModels)
    }
    
    static let dummyViewModel = FlightOffersViewModel(Offers: [
        OfferViewModel(id: "01", citiesPath: "Prague -> New York", priceInDollars: "$119", airportsPath: "PRG → JFK · 2 stops", extraInformation: "12 hours total · other info"),
        OfferViewModel(id: "01", citiesPath: "Prague -> New York", priceInDollars: "$129", airportsPath: "PRG → JFK · 2 stops", extraInformation: "12 hours total · other info"),
        OfferViewModel(id: "01", citiesPath: "Prague -> New York", priceInDollars: "$139", airportsPath: "PRG → JFK · 2 stops", extraInformation: "12 hours total · other info"),
        OfferViewModel(id: "01", citiesPath: "Prague -> New York", priceInDollars: "$149", airportsPath: "PRG → JFK · 2 stops", extraInformation: "12 hours total · other info"),
        OfferViewModel(id: "01", citiesPath: "Prague -> New York", priceInDollars: "$159", airportsPath: "PRG → JFK · 2 stops", extraInformation: "12 hours total · other info")
    ])
}
