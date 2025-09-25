import Foundation

enum ErrorsStrings: String {
    case invalidURL = "invalidURL"
    case noInternet = "noInternet"
    case serverUnavailable = "serverUnavailable"
    case timeout = "timeout"
    case invalidResponse = "invalidResponse"
    case invalidRequest = "invalidRequest"
    case unknow = "unknow"

    var localized: String {
        NSLocalizedString(self.rawValue, tableName: "Home", comment: "")
    }
}
