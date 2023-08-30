import Foundation

struct APIConfig {
    let hotelURL = "https://run.mocky.io/v3/35e0d18e-2521-4f1b-a575-f0fe366f66e3"
}

enum APICallKeys {
    case hotel
    case room
}

enum APIError: Error {
    case invalidURL
    case noData
    case networkError(Error)
    case decodingError(Error)
}

final class APIService {
    static let shared = APIService()
    func getData(apiKey: APICallKeys,
                 completion: @escaping (Result<HotelData, APIError>) -> Void) {
        guard let url = URL(string: APIConfig().hotelURL) else {
            completion(.failure(.invalidURL))
            return
        }
//        var request = URLRequest(url: url)
//        request.addValue(apiKey, forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let hotelData = try JSONDecoder().decode(HotelData.self, from: data)
                completion(.success(hotelData))
            } catch let decodingError {
                completion(.failure(.decodingError(decodingError)))
            }
        }
        task.resume()
    }
}
