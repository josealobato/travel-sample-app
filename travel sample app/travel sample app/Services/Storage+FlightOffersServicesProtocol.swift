import Foundation

// Storage conforming to `FlightOffersServicesProtocol` to be able to
// inject it on the `FlightOffers` Feature.
extension Storage: FlightOffersServicesProtocol {
    
    func flights() async throws -> [FlightOfferEntity] {

        // Places will be used later to filter itineraries.
//        let places = try await places()
//        print(places)
        
        let intineraries = try await onewayItineraries()
        return intineraries
    }
}

