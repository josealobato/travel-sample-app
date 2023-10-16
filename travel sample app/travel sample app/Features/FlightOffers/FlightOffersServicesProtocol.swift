import Foundation

// Flight Offers Feature Publis Services Protocol
//
// The application shoujld provide an object confroming to this protocol
// to allow the FlightOffers Features to function.
public protocol FlightOffersServicesProtocol {
    
    func flights() async throws -> [FlightOfferEntity]
}
