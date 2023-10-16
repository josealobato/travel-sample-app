import SwiftUI

// Public Builder of the `FlightOffers` Feature.
public struct FlightOffersBuilder {
    
    public static func build(services: FlightOffersServicesProtocol) -> some View {
        
        let interactor = FlightOffersInteractor(services: services)
        let presenter = FlightOffersPresenter()
        
        let view = FlightOffersView(presenter: presenter,
                                          eventHandler: interactor)
        
        return view
    }
}
