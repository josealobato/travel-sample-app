import Foundation

// Business entity depicting an Flight Offer .
// NOTE: Entities are marked as public because they should be on a Entities Package.
public struct FlightOfferEntity: Identifiable, Equatable {
    
    public let id: String
    
    public let durationInSec: Int
    public let princeInEur: String
    
    public let segments: [Segment]
    
    public struct Segment: Identifiable, Equatable {
        public let id: String
        public let durationInSec: Int
        public let source: Location
        public let destination: Location
    }
    
    public struct Location: Identifiable, Equatable {
        public let id: String
        public let name: String
        public let code: String
        public let city: PlaceEntity
    }
}
