extension NetworkServiceImpl {
    func fetchPokemons(numberOfItems: Int, offset: Int) async throws -> GetPokeListResponse {
        let params = NetworkParams(
            url: "\(NetworkConfig.shared.baseUrl)pokemon",
            queryItems: [.init(name: "numberOfItems", value: String(numberOfItems)),
                         .init(name: "offset", value: String(offset))])
        
        return try await self.provider.request(params)
    }
}
