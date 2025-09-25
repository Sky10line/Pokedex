final class FetchPokemonDetailsUseCase {
    private var repository: PokemonRepository

    public init(repository: PokemonRepository = PokemonRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute(endpoint: String) async throws -> PokemonDetails {
        let details = try await repository.fetchDetails(endpoint: endpoint)

        return details
    }
}
