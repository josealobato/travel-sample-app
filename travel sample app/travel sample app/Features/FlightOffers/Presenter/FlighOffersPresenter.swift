import Foundation

import UIKit

final class FlightOffersPresenter: ObservableObject, FlightOffersInteractorOutput {
    
    // MARK: - View Data
    @Published var viewModel = FlightOffersViewModel.empty
    @Published var isLoading = false  // TODO: to hide.
    
    // MARK: - InteractorOutput
    
    func dispatch(_ event: FlightOffersInteractorEvents.Output) {
        
        switch event {
            
        case .startLoading:
            isLoading = true
            
        case .noData:
            isLoading = false
            
        case .refresh(let flights):
            isLoading = false
            viewModel = FlightOffersViewModel.build(from: flights)
        }
    }
}

