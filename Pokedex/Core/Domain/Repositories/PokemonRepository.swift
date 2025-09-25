protocol PokemonRepository {
    func fetchList(numberOfItems: Int, offset: Int) async throws -> PokemonList
    func fetchDetails(endpoint: String) async throws -> PokemonDetails
}
