import Foundation

struct GraphqlQuery {
    
    static var places: String {
        """
        query places {
          places(
            search: {term: ""}
            filter: {onlyTypes: [AIRPORT, CITY], groupByCity: true}
            options: {sortBy: RANK}
            first: 20
          ) {
            ... on PlaceConnection {
              edges {
                node {
                  id
                  legacyId
                  name
                  gps {
                    lat
                    lng
                  }
                }
              }
            }
          }
        }
        """
    }
    
    static func onewayItineraries() -> String {
        """
        fragment stopDetails on Stop {
          utcTime
          localTime
          station {
            id
            name
            code
            type
            city {
              id
              legacyId
              name
              country {
                id
                name
              }
            }
          }
        }

        query onewayItineraries {
          onewayItineraries(
            filter: {allowChangeInboundSource: false, allowChangeInboundDestination: false, allowDifferentStationConnection: true, allowOvernightStopover: true, contentProviders: [KIWI], limit: 10, showNoCheckedBags: true, transportTypes: [FLIGHT]}
            options: {
              currency: "EUR", partner: "skypicker", sortBy: QUALITY, sortOrder: ASCENDING, sortVersion: 4, storeSearch: true}
            search: {
              cabinClass: {applyMixedClasses: true, cabinClass: ECONOMY},
              itinerary: {
                source: {ids: ["City:reus_es"]},
                destination: {ids: ["City:new-york-city_ny_us","City:palma_es","City:barcelona_es","City:minorca_es"]},
                # outboundDepartureDate: {start: "2023-07-01T00:00:00", end: "2023-07-01T23:59:00"}
              },
              passengers: {adults: 1, adultsHandBags: [1], adultsHoldBags: [0]}}
          ) {
            ... on Itineraries {
              itineraries {
                ... on ItineraryOneWay {
                  id
                  duration
                  # cabinClasses
                  priceEur {
                    amount
                  }
                  # bookingOptions {
                  #   edges {
                  #     node {
                  #       bookingUrl
                  #       price {
                  #         amount
                  #         formattedValue
                  #       }
                  #     }
                  #   }
                  # }
                  # provider {
                  #   id
                  #   name
                  #   code
                  # }
                  sector {
                    id
                    duration
                    sectorSegments {
                      segment {
                        id
                        duration
                        type
                        code
                        source {
                          ...stopDetails
                        }
                        destination {
                          ...stopDetails
                        }
                        carrier {
                          id
                          name
                          code
                        }
                        operatingCarrier {
                          id
                          name
                          code
                        }
                      }
        #                      layover {
        #                        duration
        #                        isBaggageRecheck
        #                        transferDuration
        #                        transferType
        #                      }
        #                      guarantee
                    }
                  }
                 }
              }
            }
          }
        }
        """
    }
    
    static func onewayItineraries(from places: [String], departureStart: String, departureEnd: String) -> String {
        """
        fragment stopDetails on Stop {
          utcTime
          localTime
          station {
            id
            name
            code
            type
            city {
              id
              legacyId
              name
              country {
                id
                name
              }
            }
          }
        }

        query onewayItineraries {
          onewayItineraries(
            filter: {allowChangeInboundSource: false, allowChangeInboundDestination: false, allowDifferentStationConnection: true, allowOvernightStopover: true, contentProviders: [KIWI], limit: 10, showNoCheckedBags: true, transportTypes: [FLIGHT]}
            options: {
              currency: "EUR", partner: "skypicker", sortBy: QUALITY, sortOrder: ASCENDING, sortVersion: 4, storeSearch: true}
            search: {
              cabinClass: {applyMixedClasses: true, cabinClass: ECONOMY},
              itinerary: {
                source: {ids: [\(places.map{ "\"\($0)\""}.joined(separator: ","))]},
                #  destination: {ids: ["City:new-york-city_ny_us","City:palma_es","City:barcelona_es","City:minorca_es"]},
                outboundDepartureDate: {start: "\(departureStart)", end: "\(departureEnd)"}
              },
              passengers: {adults: 1, adultsHandBags: [1], adultsHoldBags: [0]}}
          ) {
            ... on Itineraries {
              itineraries {
                ... on ItineraryOneWay {
                  id
                  duration
                  # cabinClasses
                  priceEur {
                    amount
                  }
                  sector {
                    id
                    duration
                    sectorSegments {
                      segment {
                        id
                        duration
                        type
                        code
                        source {
                          ...stopDetails
                        }
                        destination {
                          ...stopDetails
                        }
                        carrier {
                          id
                          name
                          code
                        }
                        operatingCarrier {
                          id
                          name
                          code
                        }
                      }
                    }
                  }
                 }
              }
            }
          }
        }
        """
    }
}
