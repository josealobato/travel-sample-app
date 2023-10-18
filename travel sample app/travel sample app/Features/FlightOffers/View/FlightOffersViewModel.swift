import Foundation

struct FlightOffersViewModel {
    
    struct OfferViewModel: Identifiable, Equatable {
        
        let id: String
        let citiesPath: String
        let price: String
        let airportsPath: String
        let extraInformation: String
        let imagePath: String
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
            guard let lastSegment = entity.segments.last else { return nil }
            citiesPath = "\(firstSegment.source.name) → \(lastSegment.destination.name)"
            airportPath = "\(firstSegment.source.code)"
            
            for i in 0..<c {
                airportPath.append(" → \(entity.segments[i].destination.code)")
            }
            
        default:
            return nil
        }
        
        let price = entity.princeInEur + "€"
        
        var imagePath = ""
        if let destinationLegacyId = entity.segments.last?.destination.city.legacyId {
            imagePath = "https://images.kiwi.com/photos/600x600/\(destinationLegacyId).jpg"
        }
            
        let extraInformation = FlightOffersViewModel.formatTimeDuration(seconds: entity.durationInSec)
        
        return FlightOffersViewModel.OfferViewModel(id: entity.id,
                                                    citiesPath: citiesPath,
                                                    price: price,
                                                    airportsPath: airportPath,
                                                    extraInformation: extraInformation,
                                                    imagePath: imagePath)
    }
}

extension FlightOffersViewModel {
    
    static func build(from flights: [FlightOfferEntity]) -> FlightOffersViewModel {
  
        let offersViewModels = flights.compactMap { FlightOffersViewModel.OfferViewModel.from(entity: $0) }

        return FlightOffersViewModel(Offers: offersViewModels)
    }
    
    // MARK: - Helpers
    
    /// Formats a time in seconds to the format "1h 30min"
    /// If there is no hour only the minutes are shown.
    /// If there is no minutes only the hours are shown.
    /// - Parameter seconds: The seconds to convert and display.
    /// - Returns: the formated string.
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
