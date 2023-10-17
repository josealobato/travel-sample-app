import Foundation

// Storage Extension for getting itineraries on remote storage.
extension Storage {
    
    static var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter
    }
    
    func onewayItineraries(from places: [PlaceEntity], date: Date ) async throws -> [FlightOfferEntity] {
        
        let placesRequest = try oneWayIntinerariesRequest(from: places, date: date)
        let (data, _) = try await URLSession.shared.data(for: placesRequest)
        
        let responseData = try JSONDecoder().decode(OnewayItinerariesResponse.self, from: data)
        
        let entities = responseData.entities()
        return entities
    }
    
    private func oneWayIntinerariesRequest(from places: [PlaceEntity], date: Date)  throws -> URLRequest {
        
        guard let url = URL(string: "https://api.skypicker.com/umbrella/v2/graphql") else {
            throw StorageError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Body
        
        let places = places.map { $0.id }
        
        let (firstMinute, lastMinute) = getFirstAndLastMinute(of: date)
        let departureStart = Storage.dateFormatter.string(from: firstMinute)
        let departureEnd = Storage.dateFormatter.string(from: lastMinute)
        
        let parameters: [String: Any] = [
            "query": GraphqlQuery.onewayItineraries(from: places, departureStart: departureStart, departureEnd: departureEnd)
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed)
        } catch {
            throw StorageError.invalidQuery
        }
        
        return request
    }
    
    // MARK: - Helpers
    
    func getFirstAndLastMinute(of date: Date) -> (firstMinute: Date, lastMinute: Date) {
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        
        let startOfDay = calendar.date(from: components)!
        let endOfDay = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: startOfDay)!
        
        return (startOfDay, endOfDay)
    }
}
