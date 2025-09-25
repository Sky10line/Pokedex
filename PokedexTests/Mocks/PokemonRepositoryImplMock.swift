@testable import Pokedex

final class PokemonRepositoryImplMock: PokemonRepository {
    var list: PokemonList = .init(total: 0, offset: 0, items: [])
    var details: PokemonDetails = .init()
    
    func setList(_ list: PokemonList) {
        self.list = list
    }
    
    func setDetails(_ details: PokemonDetails) {
        self.details = details
    }
    
    func fetchList(numberOfItems: Int, offset: Int) async throws -> PokemonList {
        return list
    }
    
    func fetchDetails(endpoint: String) async throws -> PokemonDetails {
        return details
    }
}
