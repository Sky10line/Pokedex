struct GetDetailsResponse: Codable {
    let name: String?
    let height: Int?
    let weight: Int?
    let sprites: GetDetailsSprites?
    let types: [GetDetailsTypes]?
}

struct GetDetailsSprites: Codable {
    let front_default: String?
}

struct GetDetailsTypes: Codable {
    let type: GetDetailsType
}

struct GetDetailsType: Codable {
    let name: String?
}
