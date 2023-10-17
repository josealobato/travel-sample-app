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
        
        // This error is just a quick solution.
        render(.onError)
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
            
            let flights = try await services.flights().prefix(5)
            
            if flights.isEmpty {
                
                render(.noData)
            } else {
                
                render(.refresh(Array(flights)))
            }
            
        } catch {

            renderError(error)
        }
    }
    
    private func onRefresh() async {
        
        await onLoadInitialData()
    }
}

