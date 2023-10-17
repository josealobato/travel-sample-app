import Foundation

struct OnewayItinerariesResponse: Decodable {
    let data: DataContent
    
    struct DataContent: Decodable {
        let onewayItineraries: OnewayItineraries
        
        struct OnewayItineraries: Decodable {
            let itineraries: [Itinerary]
            
            struct Itinerary: Decodable {
                let id: String
                let duration: Int
                let priceEur: Price
                let sector: Sector
                
                struct Price: Decodable {
                    let amount: String
                }

                struct Sector: Decodable {
                    let id: String
                    let duration: Int
                    let sectorSegments: [SectorSegment]
                    
                    struct SectorSegment: Decodable {
                        let segment: Segment
                        let layover: String?
                        let guarantee: String?
                        
                        struct Segment: Decodable {
                            let id: String
                            let duration: Int
                            let type: String
                            let code: String
                            let source: JourneyDetail
                            let destination: JourneyDetail
                            
                            struct Carrier: Decodable {
                                let id: String
                                let name: String
                                let code: String
                            }
                            
                            struct JourneyDetail: Decodable {
                                let utcTime: String
                                let localTime: String
                                let station: Station
                                
                                struct Station: Decodable {
                                    let id: String
                                    let name: String
                                    let code: String
                                    let type: String
                                    let city: City
                                    
                                    struct City: Decodable {
                                        let id: String
                                        let legacyId: String
                                        let name: String
                                        let country: Country
                                        
                                        struct Country: Decodable {
                                            let id: String
                                            let name: String
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}


// MARK : Extensions

extension OnewayItinerariesResponse {
    func entities() -> [FlightOfferEntity] {
        return data.onewayItineraries.itineraries.map { $0.toEntity() }
    }
}

extension OnewayItinerariesResponse.DataContent.OnewayItineraries.Itinerary {
    func toEntity() -> FlightOfferEntity {
        return FlightOfferEntity(id: id,
                                 durationInSec: duration,
                                 princeInEur: priceEur.amount,
                                 segments: sector.sectorSegments.map { $0.segment.toEntity() })
    }
}

extension OnewayItinerariesResponse.DataContent.OnewayItineraries.Itinerary.Sector.SectorSegment.Segment {
    func toEntity() -> FlightOfferEntity.Segment {
        return FlightOfferEntity.Segment(id: id,
                                         durationInSec: duration,
                                         source: source.station.toEntity(),
                                         destination: destination.station.toEntity())
    }
}

extension OnewayItinerariesResponse.DataContent.OnewayItineraries.Itinerary.Sector.SectorSegment.Segment.JourneyDetail.Station {
    func toEntity() -> FlightOfferEntity.Location {
        FlightOfferEntity.Location(id: id,
                                   name: name,
                                   code: code,
                                   city: city.toEntity())
    }
}


extension OnewayItinerariesResponse.DataContent.OnewayItineraries.Itinerary.Sector.SectorSegment.Segment.JourneyDetail.Station.City {
    func toEntity() -> PlaceEntity {
        PlaceEntity(id: id, legacyId: legacyId, name: name)
    }
}
