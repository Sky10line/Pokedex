final class FetchPokemonListUseCase {
    private var repository: PokemonRepository

    public init(repository: PokemonRepository = PokemonRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute(numberOfItems: Int, currentData: PokemonList) async throws -> PokemonList {
        var list = try await repository.fetchList(numberOfItems: numberOfItems, offset: currentData.offset)
   
        var setItems: Set<String> = Set(currentData.items.map({ $0.name }))
        let filteredItems = list.items.filter { item in
            return !item.name.isEmpty && !item.detailURI.isEmpty && setItems.insert(item.name).inserted
        }
        
        var allPokemons = currentData.items
        allPokemons.append(contentsOf: filteredItems)
        list.items = allPokemons
       
        return list
    }
}
