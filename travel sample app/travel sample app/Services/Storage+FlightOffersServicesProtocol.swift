import Foundation

// Storage conforming to `FlightOffersServicesProtocol` to be able to
// inject it on the `FlightOffers` Feature.
extension Storage: FlightOffersServicesProtocol {
    
    func flights() async throws -> [FlightOfferEntity] {

        try await flightsTodayFromAllPlaces()
    }
    
    private func flightsTodayFromAllPlaces() async throws -> [FlightOfferEntity] {
        
        let places = try await places()
        
        let intineraries = try await onewayItineraries(from: places, date: Date())
        return intineraries
    }
    
    private func flightsTomorrowFromAllPlaces() async throws -> [FlightOfferEntity] {
        
        let places = try await places()
        
        let intineraries = try await onewayItineraries(from: places, date: Date(timeIntervalSinceNow: 3600 * 24))
        return intineraries
    }

}

