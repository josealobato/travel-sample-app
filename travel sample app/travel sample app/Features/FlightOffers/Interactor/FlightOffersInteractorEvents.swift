import Foundation

enum FlightOffersInteractorEvents {
    
    enum Input {
        
        case loadInitialData
        case refresh
    }
    
    enum Output: Equatable {
        
        case startLoading
        case noData
        case onError
        case refresh([FlightOfferEntity])
    }
}

// MARK: - Interactor abstraction interfaces

/// These are the interfaces that abstracts the interactor from the input (View) and output (Presenter)

protocol FlightOffersInteractorInput: AnyObject, AutoMockable {

    func request(_ event: FlightOffersInteractorEvents.Input) async
}

protocol FlightOffersInteractorOutput: AnyObject, AutoMockable {

    func dispatch(_ event: FlightOffersInteractorEvents.Output)
}

