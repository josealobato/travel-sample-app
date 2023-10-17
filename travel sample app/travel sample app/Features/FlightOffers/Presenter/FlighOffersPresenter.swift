import Foundation

import UIKit

final class FlightOffersPresenter: ObservableObject, FlightOffersInteractorOutput {
    
    enum ViewState {
        case normal, noData, loading, error
    }
    
    // MARK: - View Data
    @Published var viewModel = FlightOffersViewModel.empty
    @Published var isOnError = false
    @Published var viewState: ViewState? = nil
    
    // MARK: - InteractorOutput
    
    func dispatch(_ event: FlightOffersInteractorEvents.Output) {
        
        switch event {
            
        case .startLoading:
            isOnError = false
            viewState = .loading
            
        case .noData:
            isOnError = false
            viewState = .noData
            
        case .refresh(let flights):
            isOnError = false
            viewState = nil
            viewModel = FlightOffersViewModel.build(from: flights)
            
        case .onError:
            viewState = .error
            isOnError = true
        }
    }
}

