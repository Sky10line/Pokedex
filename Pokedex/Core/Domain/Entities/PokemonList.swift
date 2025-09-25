struct PokemonList {
    var total: Int
    var offset: Int
    var items: [PokemonListItem]
}

struct PokemonListItem: Hashable {
    var name: String
    var detailURI: String
}
