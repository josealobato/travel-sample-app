import Foundation

// Storage Extension for getting places on remote storage.
extension Storage {
    
    func places() async throws -> [PlaceEntity] {
        
        let placesRequest = try placesRequest()
        let (data, _) = try await URLSession.shared.data(for: placesRequest)
        
        let responseData = try JSONDecoder().decode(PlacesResponse.self, from: data)
        
        let entities = responseData.entities()
        return entities
    }
    
    private func placesRequest()  throws -> URLRequest {
        
        guard let url = URL(string: "https://api.skypicker.com/umbrella/v2/graphql") else {
            throw StorageError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Body
        let parameters: [String: Any] = [
            "query": GraphqlQuery.places
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed)
        } catch {
            throw StorageError.invalidQuery
        }
        
        return request
    }
}
