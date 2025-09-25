struct GetPokeListResponse: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [GetPokeListResponseItem]?
}

struct GetPokeListResponseItem: Codable {
    let name: String?
    let url: String?
}
