import Foundation

protocol NetworkProvider {
    func request<T: Codable>(_ params: NetworkParams) async throws -> T
}

final class NetworkProviderImpl: NetworkProvider {
    func request<T: Codable>(_ params: NetworkParams) async throws -> T {
        guard let url = URL(string: params.url) else {
            throw NetworkError.invalidURL
        }
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = params.httpMethod.rawValue
        
        let formattedHeader = params.header
        urlRequest.allHTTPHeaderFields = formattedHeader
        
        urlRequest.url?.append(queryItems: params.queryItems)
        
        if let body = params.body {
            do {
                let encodedBody = try JSONEncoder().encode(body)
                urlRequest.httpBody = encodedBody
            } catch {
                throw NetworkError.invalidRequestBody
            }
        }
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(statusCode: httpResponse.statusCode)
        }
        
        do {
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return decoded
        } catch {
            throw NetworkError.invalidResponse
        }
    }
}

