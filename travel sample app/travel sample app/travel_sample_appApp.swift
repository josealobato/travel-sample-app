import SwiftUI

@main
struct travel_sample_appApp: App {
    var body: some Scene {
        WindowGroup {
            
            /// Here we are buiding the `FlightOffers` feature.
            /// In general is the work of a Coordinator to build features and set them on screen.
            FlightOffersBuilder.build(services: Storage())
        }
    }
}
