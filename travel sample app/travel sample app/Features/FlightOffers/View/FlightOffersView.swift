import SwiftUI

struct FlightOffersView: View {
    
    enum ViewState {
        case Loading
    }
    
    @StateObject private var presenter: FlightOffersPresenter
    let eventHandler: FlightOffersInteractor
    
    init(presenter: FlightOffersPresenter,
         eventHandler: FlightOffersInteractor) {
        self._presenter = StateObject(wrappedValue: presenter)
        self.eventHandler = eventHandler
    }
    
    var body: some View {
        FlightOfferCollectionView(offers: presenter.viewModel.Offers)
            .onAppear { request(.loadInitialData) }
    }
    
    func request(_ event: FlightOffersInteractorEvents.Input) {

        Task {

            await eventHandler.request(event)
        }
    }
}

//struct FlightOfferFeatureView_Previews: PreviewProvider {
//    static var previews: some View {
//        FlightOfferFeatureView()
//    }
//}
