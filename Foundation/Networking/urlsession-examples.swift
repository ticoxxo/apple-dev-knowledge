// Foundation: URLSession Networking Patterns
// Source: https://developer.apple.com/documentation/foundation/urlsession

import Foundation

// MARK: - Modern Async/Await Approach
struct NetworkService {
    
    /// Fetch data with async/await
    func fetchData<T: Decodable>(from url: URL) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    /// POST request with body
    func post<T: Encodable, R: Decodable>(
        to url: URL,
        body: T
    ) async throws -> R {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200... 299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }
        
        return try JSONDecoder().decode(R.self, from: data)
    }
    
    /// Download file with progress
    func downloadFile(from url: URL) -> AsyncThrowingStream<DownloadProgress, Error> {
        AsyncThrowingStream { continuation in
            let task = URLSession.shared.downloadTask(with: url) { localURL, response, error in
                if let error = error {
                    continuation. finish(throwing: error)
                    return
                }
                
                guard let localURL = localURL else {
                    continuation.finish(throwing: NetworkError.downloadFailed)
                    return
                }
                
                continuation.yield(. completed(localURL))
                continuation.finish()
            }
            
            task.resume()
        }
    }
}

// MARK: - URLSession Configuration
extension URLSession {
    static var customSession: URLSession {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 300
        config.waitsForConnectivity = true
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        
        return URLSession(configuration:  config)
    }
}

// MARK: - Error Handling
enum NetworkError: LocalizedError {
    case invalidURL
    case invalidResponse
    case downloadFailed
    case decodingFailed
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid"
        case . invalidResponse:
            return "Invalid response from server"
        case .downloadFailed:
            return "Download failed"
        case .decodingFailed:
            return "Failed to decode response"
        }
    }
}

// MARK: - Supporting Types
enum DownloadProgress {
    case progress(Double)
    case completed(URL)
}

// MARK: - Example Usage
struct ExampleAPI {
    let service = NetworkService()
    
    func getUser(id: String) async throws -> User {
        let url = URL(string: "https://api.example.com/users/\(id)")!
        return try await service.fetchData(from: url)
    }
    
    func createUser(name: String, email: String) async throws -> User {
        let url = URL(string: "https://api.example.com/users")!
        let newUser = CreateUserRequest(name: name, email: email)
        return try await service.post(to: url, body: newUser)
    }
}

struct CreateUserRequest: Codable {
    let name: String
    let email: String
}