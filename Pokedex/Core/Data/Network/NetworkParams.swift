import Foundation
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
    case head = "HEAD"
    case options = "OPTIONS"
}

struct NetworkParams {
    var url: String
    var httpMethod: HTTPMethod
    var header: [String : String]
    var queryItems: [URLQueryItem]
    var body: Encodable?

    public init(url: String,
                httpMethod: HTTPMethod = .get,
                header: [String : String] = [:],
                queryItems: [URLQueryItem] = [],
                body: Encodable? = nil) {

        self.url = url
        self.httpMethod = httpMethod
        self.header = header
        self.queryItems = queryItems
        self.body = body
    }
}
