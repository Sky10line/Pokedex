import Foundation

public enum NetworkError: Error {
    case invalidURL
    case noInternetConnection
    case serverError(statusCode: Int)
    case timeout
    case invalidResponse
    case invalidRequestBody
    case unknown(error: String?, statusCode: Int?)
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return ErrorsStrings.invalidURL.localized
        case .noInternetConnection:
            return ErrorsStrings.noInternet.localized
        case .serverError(_):
            return ErrorsStrings.serverUnavailable.localized
        case .timeout:
            return ErrorsStrings.timeout.localized
        case .invalidResponse:
            return ErrorsStrings.invalidResponse.localized
        case .invalidRequestBody:
            return ErrorsStrings.invalidRequest.localized
        case .unknown(_, _):
            return ErrorsStrings.unknow.localized
        }
    }
}
