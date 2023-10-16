import Foundation

final class FlightOffersInteractor: FlightOffersInteractorInput {
    
    var output: FlightOffersInteractorOutput?
    var services: FlightOffersServicesProtocol
    
    init(services: FlightOffersServicesProtocol) {
        
        self.services = services
    }
    
    // MARK: - Intercator input

    func request(_ event: FlightOffersInteractorEvents.Input) async {

        switch event {

        case .loadInitialData: await onLoadInitialData()
        case .refresh: await onRefresh()
        }
    }
    
    // MARK: - Error
    
    private func renderError(_ error: Error, retryAction: (() -> Void)? = nil) {
        // Work with coordinator to show the error (Snackbar, alert, etc.)
        print("Interactor Error: \(error)")
    }

    // MARK: - Intercator output

    private func render(_ event: FlightOffersInteractorEvents.Output) {

        DispatchQueue.main.async {

            self.output?.dispatch(event)
        }
    }
    
    // MARK: - Interaction management
    
    private func onLoadInitialData() async {

        render(.startLoading)
    
        do {
            
            let flights = try await services.flights()
            
            if flights.isEmpty {
                
                render(.noData)
            } else {
                
                render(.refresh(flights))
            }
            
        } catch {

            renderError(error)
        }
    }
    
    private func onRefresh() async {
        
        await onLoadInitialData()
    }
}

