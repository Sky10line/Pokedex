final class NetworkConfig {
    public static var shared = NetworkConfig()
    
    private init() {}
    
    var current: Environment = .development
    
    var baseUrl: String {
        switch current {
        case .development:
            return "https://pokeapi.co/api/v2/"
        }
    }
}

enum Environment {
    case development
}
