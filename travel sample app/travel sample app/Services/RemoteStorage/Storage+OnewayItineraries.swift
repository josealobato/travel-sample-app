import Foundation

// Storage Extension for getting itineraries on remote storage.
extension Storage {
    
    func onewayItineraries() async throws -> [FlightOfferEntity] {
        
        let placesRequest = try oneWayIntinerariesRequest()
        let (data, response) = try await URLSession.shared.data(for: placesRequest)
        
        let responseData = try JSONDecoder().decode(OnewayItinerariesResponse.self, from: data)
        
        let entities = responseData.entities()
        return entities
    }
    
    private func oneWayIntinerariesRequest()  throws -> URLRequest {
        
        guard let url = URL(string: "https://api.skypicker.com/umbrella/v2/graphql") else {
            throw StorageError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Body
        let parameters: [String: Any] = [
            "query": GraphqlQuery.onewayItineraries()
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed)
        } catch {
            throw StorageError.invalidQuery
        }
        
        return request
    }
}
