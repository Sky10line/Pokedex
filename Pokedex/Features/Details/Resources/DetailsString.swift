import Foundation

enum DetailsString: String {
    case title = "title"
    case infosTitle = "infosTitle"
    case heightTitle = "heightTitle"
    case weightTitle = "weightTitle"
    case typesTitle = "typesTitle"
    case loading = "loading"
    case retryButton = "retryButton"
    case error = "error"
    
    var localized: String {
        NSLocalizedString(self.rawValue, tableName: "Details", comment: "")
    }
}
