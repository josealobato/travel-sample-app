import XCTest
@testable import travel_sample_app

final class FlightOfferInteractorOnInitialLoad: XCTestCase {
    
    var interactor: FlightOffersInteractor!
    var outpuMock: FlightOffersInteractorOutputMock!
    var servicesMock: FlightOffersServicesProtocolMock!
    
    override func setUp() {
        
        outpuMock = FlightOffersInteractorOutputMock()
        servicesMock = FlightOffersServicesProtocolMock()
        
        interactor = FlightOffersInteractor(services: servicesMock)
        interactor.output = outpuMock
    }
    
    func test_onInitialLoad() async throws {
        // Given the interactor wired up with a service with data
        servicesMock.flightsReturnValue = offerEntities()
        
        // When it receives the request to load initial data
        await interactor.request(.loadInitialData)
        
        // Then it will call the service for data ...
        XCTAssertTrue(servicesMock.flightsCalled)
        // ... and will render start loading and after the given data.
        XCTAssertEqual(outpuMock.dispatchReceivedInvocations,
                       [FlightOffersInteractorEvents.Output.startLoading,
                        FlightOffersInteractorEvents.Output.refresh(offerEntities())])
    }
    
    func test_onInitialLoadWithError() async throws {
        // Given the interactor wired up with a service that returns an error on flights request.
        servicesMock.flightsThrowableError = StorageError.invalidQuery
        
        // When it receives the request to load initial data
        await interactor.request(.loadInitialData)
        
        // Then it will render start loading and then the error.
        XCTAssertEqual(outpuMock.dispatchReceivedInvocations,
                       [FlightOffersInteractorEvents.Output.startLoading,
                        FlightOffersInteractorEvents.Output.onError])
    }
    
    // MARK: - Data Limit
    
    func test_onInitialLoadFlightsWillBeLimitedToFive() async throws {
        // Given the interactor wired up with a service that returns many data
        servicesMock.flightsReturnValue = offerManyEntities()
        XCTAssert(servicesMock.flightsReturnValue.count > 5)
        
        // When it receives the request to load initial data
        await interactor.request(.loadInitialData)
        
        // Then it will limit the fetched data to 5 elements
        let refreshRender = outpuMock.dispatchReceivedInvocations[1]
        if case let FlightOffersInteractorEvents.Output.refresh(values) = refreshRender {
            XCTAssertTrue(values.count == 5)
        } else {
            XCTFail()
        }
    }
    
    // MARK: - mock data
    
    func offerEntities() -> [FlightOfferEntity] {
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
        return [offerEntity, offerEntity]
    }
    
    func offerManyEntities() -> [FlightOfferEntity] {
        let initialEntities = offerEntities()
        
        var biggerArray = [FlightOfferEntity]()
        for _ in 1...6 {
            biggerArray += initialEntities
        }

        return biggerArray
    }

}
