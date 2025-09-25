public enum LoadingState<T>: Equatable {
    public static func == (lhs: LoadingState<T>, rhs: LoadingState<T>) -> Bool {
        switch (lhs, rhs) {
        case (.none, .none): return true
        case (.loading, .loading): return true
        case (.success, .success): return true
        case (.error, .error): return true
        default: return false
        }
    }

    case none
    case loading
    case success(T)
    case error(NetworkError)
}
