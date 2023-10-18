import Foundation

// Flight Offers Feature Public Services Protocol
//
// The application shoujld provide an object confroming to this protocol
// to allow the FlightOffers Features to function.
public protocol FlightOffersServicesProtocol: AutoMockable {
    
    func flights() async throws -> [FlightOfferEntity]
}
