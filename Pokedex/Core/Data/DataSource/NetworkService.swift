protocol NetworkService {
    func fetchPokemons(numberOfItems: Int, offset: Int) async throws -> GetPokeListResponse
    func fetchDetails(endpoint: String) async throws -> GetDetailsResponse
}

struct NetworkServiceImpl: NetworkService {
    let provider: NetworkProvider

    init(provider: NetworkProvider = NetworkProviderImpl()) {
        self.provider = provider
    }
}
