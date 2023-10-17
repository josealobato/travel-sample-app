import Foundation

struct FlightOffersViewModel {
    
    struct OfferViewModel: Identifiable, Equatable {
        
        let id: String
        let citiesPath: String
        let price: String
        let airportsPath: String
        let extraInformation: String
    }
    
    let Offers: [OfferViewModel]
    
    static var empty: FlightOffersViewModel {
        
        FlightOffersViewModel(Offers: [])
    }
}

extension FlightOffersViewModel.OfferViewModel {
    static func from(entity: FlightOfferEntity) -> FlightOffersViewModel.OfferViewModel? {
        
        var citiesPath = ""
        var airportPath = ""
        switch entity.segments.count {
        case 1:
            guard let segment = entity.segments.first else { return nil }
            citiesPath = "\(segment.source.name) → \(segment.destination.name)"
            airportPath = "\(segment.source.code) → \(segment.destination.code)"
            
        case let c where c > 1:
            
            guard let firstSegment = entity.segments.first else { return nil }
            guard let lastSegment = entity.segments.first else { return nil }
            citiesPath = "\(firstSegment.source.name) → \(lastSegment.destination.name)"
            airportPath = "\(firstSegment.source.code)"
            
            for i in 1..<c {
                airportPath.append(" → \(entity.segments[i].destination.code)")
            }
            
        default:
            return nil
        }
        
        let price = entity.princeInEur + "€"
        
        // I'm ignoring minutes here.
        let extraInformation = FlightOffersViewModel.formatTimeDuration(seconds: entity.durationInSec)
        
        return FlightOffersViewModel.OfferViewModel(id: entity.id,
                                                    citiesPath: citiesPath,
                                                    price: price,
                                                    airportsPath: airportPath,
                                                    extraInformation: extraInformation)
    }
}

extension FlightOffersViewModel {
    
    static func build(from flights: [FlightOfferEntity]) -> FlightOffersViewModel {
  
//        dummyViewModel
        let offersViewModels = flights.compactMap { FlightOffersViewModel.OfferViewModel.from(entity: $0) }

        return FlightOffersViewModel(Offers: offersViewModels)
    }
    
    static let dummyViewModel = FlightOffersViewModel(Offers: [
        OfferViewModel(id: "01", citiesPath: "Prague -> New York", price: "$119", airportsPath: "PRG → JFK · 2 stops", extraInformation: "12 hours total · other info"),
        OfferViewModel(id: "02", citiesPath: "Paris -> New York", price: "$129", airportsPath: "PRG → JFK · 2 stops", extraInformation: "12 hours total · other info"),
        OfferViewModel(id: "03", citiesPath: "Rome -> New York", price: "$139", airportsPath: "PRG → JFK · 2 stops", extraInformation: "12 hours total · other info"),
        OfferViewModel(id: "04", citiesPath: "Barcelona -> New York", price: "$149", airportsPath: "PRG → JFK · 2 stops", extraInformation: "12 hours total · other info"),
        OfferViewModel(id: "05", citiesPath: "Verona -> New York", price: "$159", airportsPath: "PRG → JFK · 2 stops", extraInformation: "12 hours total · other info")
    ])
    
    // MARK: - Helpers
    
    static func formatTimeDuration(seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60

        if hours > 0 {
            if minutes > 0 {
                return "\(hours)h \(minutes)min"
            } else {
                return "\(hours)h"
            }
        } else {
            return "\(minutes)min"
        }
    }
}


// Helpers
