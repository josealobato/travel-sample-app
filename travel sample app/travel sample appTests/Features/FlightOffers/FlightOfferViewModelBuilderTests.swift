import XCTest
@testable import travel_sample_app

final class FlightOfferViewModelBuilderTests: XCTestCase {
    
    // MARK: - empty
    
    func test_emptyViewModel() throws {
        // Given the `FlightOffersViewModel` type
        // When requesting an empty view model
        let viewModel = FlightOffersViewModel.empty
        // Then it contains no offerings
        XCTAssertTrue(viewModel.Offers.count == 0)
    }
    
    // MARK: - Price
    
    func test_viewModelBuildPrice() throws {
        // Given a FlightOfferEntity with a price
        let entities = [offerEntityWithOneSegment()]
        
        // When coverted
        let viewModel = FlightOffersViewModel.build(from: entities)
        
        // Then it have the price with the format "100€"
        XCTAssertEqual(viewModel.Offers[0].price, "99€")
    }
    
    // MARK: - Extra info
    
    func test_viewModelBuildExtraInformationWithLessThanOneHour() throws {
        // Given a FlightOfferEntity with a duration less than one our
        let entities = [offerEntityWithOneSegment()]
        
        // When coverted
        let viewModel = FlightOffersViewModel.build(from: entities)
        
        // Then it have the duration with the format "MMmin"
        XCTAssertEqual(viewModel.Offers[0].extraInformation, "59min")
    }
    
    func test_viewModelBuildExtraInformationWithMoreThanOneHour() throws {
        // Given a FlightOfferEntity with a duration more than one our
        let entities = [offerEntityWithTwoSegment()]
        
        // When coverted
        let viewModel = FlightOffersViewModel.build(from: entities)
        
        // Then it have the duration with the format "HHh MMmin"
        XCTAssertEqual(viewModel.Offers[0].extraInformation, "1h 10min")
    }
    
    // MARK: - Paths for one Segment
    
    func test_viewModelBuildCitiesPathWithOneSegment() throws {
        // Given a FlightOfferEntity with one segment
        let entities = [offerEntityWithOneSegment()]
        
        // When coverted
        let viewModel = FlightOffersViewModel.build(from: entities)
        
        // Then it have the city path use the data in that segment
        XCTAssertEqual(viewModel.Offers[0].citiesPath, "Barcelona–El Prat → Palma de Mallorca")
    }
    
    func test_viewModelBuildAirportPathWithOneSegment() throws {
        // Given a FlightOfferEntity with one segment
        let entities = [offerEntityWithOneSegment()]
        
        // When coverted
        let viewModel = FlightOffersViewModel.build(from: entities)
        
        // Then it have the airports path use the data in that segment
        XCTAssertEqual(viewModel.Offers[0].airportsPath, "BCN → PMI")
    }
    
    // MARK: - Paths for Two Segment
    
    func test_viewModelBuildCitiesPathWithTwoSegment() throws {
        // Given a FlightOfferEntity with two segment
        let entities = [offerEntityWithTwoSegment()]
        
        // When coverted
        let viewModel = FlightOffersViewModel.build(from: entities)
        
        // Then it have the city path with both segments
        XCTAssertEqual(viewModel.Offers[0].citiesPath, "Barcelona–El Prat → Zaragoza")
    }
    
    func test_viewModelBuildAirportPathWithTowSegment() throws {
        // Given a FlightOfferEntity with two segment
        let entities = [offerEntityWithTwoSegment()]
        
        // When coverted
        let viewModel = FlightOffersViewModel.build(from: entities)
        
        // Then it have the airports path use the data in Both
        XCTAssertEqual(viewModel.Offers[0].airportsPath, "BCN → PMI → ZAG")
    }
    
    // MARK: - mock data
    
    func offerEntityWithOneSegment() -> FlightOfferEntity {
        let location1 = FlightOfferEntity.Location(id: "Station:airport:BCN",
                                                   name: "Barcelona–El Prat",
                                                   code: "BCN",
                                                   city: PlaceEntity(id: "City:barcelona_es",
                                                                     legacyId: "barcelona_es",
                                                                     name: "Barcelona"))
        
        let location2 = FlightOfferEntity.Location(id: "Station:airport:PMI",
                                                   name: "Palma de Mallorca",
                                                   code: "PMI",
                                                   city: PlaceEntity(id: "City:palma_es",
                                                                     legacyId: "palma_es",
                                                                     name: "Palma, Majorca"))
        
        let segments = [
            FlightOfferEntity.Segment(id: "ids1",
                                      durationInSec: 59 * 60,
                                      source: location1,
                                      destination:location2)
        ]
        
        let offerEntity = FlightOfferEntity(id: "id1",
                                            durationInSec: 59 * 60,
                                            princeInEur: "99",
                                            segments: segments)
        return offerEntity
    }
    
    func offerEntityWithTwoSegment() -> FlightOfferEntity {
        let location1 = FlightOfferEntity.Location(id: "Station:airport:BCN",
                                                   name: "Barcelona–El Prat",
                                                   code: "BCN",
                                                   city: PlaceEntity(id: "City:barcelona_es",
                                                                     legacyId: "barcelona_es",
                                                                     name: "Barcelona"))
        
        let location2 = FlightOfferEntity.Location(id: "Station:airport:PMI",
                                                   name: "Palma de Mallorca",
                                                   code: "PMI",
                                                   city: PlaceEntity(id: "City:palma_es",
                                                                     legacyId: "palma_es",
                                                                     name: "Palma, Majorca"))
        
        let location3 = FlightOfferEntity.Location(id: "City:zaragoza_es",
                                                   name: "Zaragoza",
                                                   code: "ZAG",
                                                   city: PlaceEntity(id: "City:zaragoza_es",
                                                                     legacyId: "zaragoza_es",
                                                                     name: "Palma, Majorca"))
        
        let segments = [
            FlightOfferEntity.Segment(id: "ids1",
                                      durationInSec: 59 * 60,
                                      source: location1,
                                      destination:location2),
            FlightOfferEntity.Segment(id: "ids2",
                                      durationInSec: 11 * 60,
                                      source: location2,
                                      destination:location3)
        ]
        
        let offerEntity = FlightOfferEntity(id: "id1",
                                            durationInSec: 70 * 60,
                                            princeInEur: "99",
                                            segments: segments)
        return offerEntity
    }
    
}
