extension NetworkServiceImpl {
    func fetchDetails(endpoint: String) async throws -> GetDetailsResponse {
        let params = NetworkParams(
            url: "\(NetworkConfig.shared.baseUrl)\(endpoint)")
        
        return try await self.provider.request(params)
    }
}
