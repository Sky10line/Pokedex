final class PokemonRepositoryImpl: PokemonRepository {
    private let service: NetworkService
    
    init(service: NetworkService = NetworkServiceImpl()) {
        self.service = service
    }
    
    func fetchList(numberOfItems: Int, offset: Int) async throws -> PokemonList {
        let response = try await self.service.fetchPokemons(numberOfItems: numberOfItems, offset: offset)
        
        return PokemonList(
            total: response.count ?? 0,
            offset: offset + numberOfItems,
            items: response.results?.map({ item in
                PokemonListItem(name: item.name ?? "", detailURI: String(item.url?.split(separator: "/v2/").last ?? ""))
            }) ?? []
        )
    }
    
    func fetchDetails(endpoint: String) async throws -> PokemonDetails {
        let response = try await self.service.fetchDetails(endpoint: endpoint)
        
        return PokemonDetails(name: response.name,
                              height: response.height,
                              weight: response.weight,
                              image: response.sprites?.front_default,
                              types: response.types?.map({ $0.type.name ?? "" }))
    }
}
