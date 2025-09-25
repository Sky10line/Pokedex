@testable import Pokedex
import XCTest

final class FetchPokemonListUseCaseTests: XCTestCase {
    var repository: PokemonRepositoryImplMock!
    var useCase: FetchPokemonListUseCase!
    
    override func setUp() async throws {
        try await super.setUp()
        
        repository = PokemonRepositoryImplMock()
        useCase = FetchPokemonListUseCase(repository: repository)
    }
    
    override func tearDown() async throws {
        repository = nil
        useCase = nil
        
        try await super.tearDown()
    }
    
    func test_removingEmptyElements() {
        repository.setList(.init(total: 29, offset: 6, items: [
            .init(name: "Pokemon 1", detailURI: "https://pokeapi.co/api/v2/pokemon/1"),
            .init(name: "Pokemon 2", detailURI: "https://pokeapi.co/api/v2/pokemon/2"),
            .init(name: "", detailURI: "https://pokeapi.co/api/v2/pokemon/2"),
            .init(name: "Pokemon 3", detailURI: "https://pokeapi.co/api/v2/pokemon/3"),
            .init(name: "", detailURI: "https://pokeapi.co/api/v2/pokemon/3"),
            .init(name: "Pokemon 4", detailURI: "https://pokeapi.co/api/v2/pokemon/4"),
        ]))
        
        Task {
            let list = try await useCase.execute(numberOfItems: 0, currentData: .init(total: 0, offset: 0, items: []))
            
            XCTAssertEqual(list.items.count, 4)
        }
    }
    
    func test_removingDuplicatedElements() async {
        repository.setList(.init(total: 29, offset: 6, items: [
            .init(name: "Pokemon 1", detailURI: "https://pokeapi.co/api/v2/pokemon/1"),
            .init(name: "Pokemon 2", detailURI: "https://pokeapi.co/api/v2/pokemon/2"),
            .init(name: "Pokemon 2", detailURI: "https://pokeapi.co/api/v2/pokemon/2"),
            .init(name: "Pokemon 3", detailURI: "https://pokeapi.co/api/v2/pokemon/3"),
            .init(name: "Pokemon 3", detailURI: "https://pokeapi.co/api/v2/pokemon/3"),
            .init(name: "Pokemon 4", detailURI: "https://pokeapi.co/api/v2/pokemon/4"),
            .init(name: "Pokemon 5", detailURI: "https://pokeapi.co/api/v2/pokemon/5"),
        ]))
        
        Task {
            let list = try await useCase.execute(numberOfItems: 0, currentData: .init(total: 0, offset: 0, items: []))
            
            XCTAssertEqual(list.items.count, 5)
        }
    }
    
    func test_removingRepeatedElements() async {
        repository.setList(.init(total: 29, offset: 6, items: [
            .init(name: "Pokemon 1", detailURI: "https://pokeapi.co/api/v2/pokemon/1"),
            .init(name: "Pokemon 2", detailURI: "https://pokeapi.co/api/v2/pokemon/2"),
            .init(name: "Pokemon 3", detailURI: "https://pokeapi.co/api/v2/pokemon/3"),
        ]))
        
        Task {
            let list = try await useCase.execute(numberOfItems: 0, currentData: .init(total: 0, offset: 0, items: [
                .init(name: "Pokemon 1", detailURI: "https://pokeapi.co/api/v2/pokemon/1"),
                .init(name: "Pokemon 2", detailURI: "https://pokeapi.co/api/v2/pokemon/2"),
            ]))
            
            XCTAssertEqual(list.items.count, 3)
        }
    }
    
    func test_appendingToExistingList() async {
        repository.setList(.init(total: 29, offset: 6, items: [
            .init(name: "Pokemon 1", detailURI: "https://pokeapi.co/api/v2/pokemon/1"),
            .init(name: "Pokemon 2", detailURI: "https://pokeapi.co/api/v2/pokemon/2"),
            .init(name: "Pokemon 3", detailURI: "https://pokeapi.co/api/v2/pokemon/3"),
        ]))
        
        Task {
            let list = try await useCase.execute(numberOfItems: 0, currentData: .init(total: 0, offset: 0, items: [
                .init(name: "Pokemon 4", detailURI: "https://pokeapi.co/api/v2/pokemon/4"),
                .init(name: "Pokemon 5", detailURI: "https://pokeapi.co/api/v2/pokemon/5"),
            ]))
            
            XCTAssertEqual(list.items.count, 5)
        }
    }
}
