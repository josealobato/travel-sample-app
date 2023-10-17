import Foundation

struct PlacesResponse: Codable {
    let data: DataClass
    
    struct DataClass: Codable {
        let places: Places
        
        struct Places: Codable {
            let edges: [Edge]
            
            struct Edge: Codable {
                let node: Node
                
                struct Node: Codable {
                    let id: String
                    let legacyId: String
                    let name: String
                    let gps: GPS
                    
                    struct GPS: Codable {
                        let lat: Double
                        let lng: Double
                    }
                }
            }
        }
    }
}

extension PlacesResponse {
    func entities() -> [PlaceEntity] {
        return data.places.edges.map { $0.node.toEntity() }
    }
}

extension PlacesResponse.DataClass.Places.Edge.Node {
    func toEntity() -> PlaceEntity {
        return PlaceEntity(id: id, legacyId: legacyId, name: name)
    }
}

