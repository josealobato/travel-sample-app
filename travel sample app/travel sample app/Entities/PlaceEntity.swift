import Foundation

// Entity representing a Place
// NOTE: Entities are marked as public because they should be on a Entities Package.
public struct PlaceEntity: Equatable, Identifiable {
    
    public let id: String
    public let legacyId: String
    public let name: String
}
