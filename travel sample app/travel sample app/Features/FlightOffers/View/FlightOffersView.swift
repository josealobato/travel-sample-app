import SwiftUI

struct FlightOffersView: View {
    
    @StateObject private var presenter: FlightOffersPresenter
    let eventHandler: FlightOffersInteractor
    
    init(presenter: FlightOffersPresenter,
         eventHandler: FlightOffersInteractor) {
        self._presenter = StateObject(wrappedValue: presenter)
        self.eventHandler = eventHandler
    }
    
    var body: some View {
        
        if case .noData = presenter.viewState {
            
            Text("No Data!")
                .font(.title)
            Text("Ups It seems there is no data to show.")
            Text("(...and we need a designer!)")
            
        } else  {
            
            FlightOfferCollectionView(offers: presenter.viewModel.Offers)
                .onAppear { request(.loadInitialData) }
                .overlay(
                    
                    Group {
                        if case .loading = presenter.viewState {
                            Color.black.opacity(0.5)
                                .ignoresSafeArea()
                            
                            ProgressView()
                                .foregroundColor(Color.white)
                        }
                    }
                )
                .alert(isPresented: $presenter.isOnError) {
                    Alert(
                        title: Text("Error"),
                        message: Text("Something went wrong!"),
                        dismissButton: .default(Text("Retry")) {
                            request(.loadInitialData)
                        }
                    )
                }
        }
    }
    
    func request(_ event: FlightOffersInteractorEvents.Input) {
        
        Task {
            
            await eventHandler.request(event)
        }
    }
}

