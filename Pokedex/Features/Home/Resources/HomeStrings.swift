import Foundation

enum HomeStrings: String {
    case title = "title"
    case retryButton = "retryButton"
    case error = "error"
    case loading = "loading"

    var localized: String {
        NSLocalizedString(self.rawValue, tableName: "Home", comment: "")
    }
}
