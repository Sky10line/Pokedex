import Foundation
import SwiftUICore

@MainActor
protocol DetailsViewModelProtocol: ObservableObject {
    var viewState: LoadingState<DetailsInfo> { get }
    
    func fetchDetails()
}

final class DetailsViewModel: DetailsViewModelProtocol {
    @Published public var viewState: LoadingState<DetailsInfo> = .none
    
    private let detailsUseCase: FetchPokemonDetailsUseCase
    private let detailsUrl: String
    
    init(detailsUrl: String, detailsUseCase: FetchPokemonDetailsUseCase = FetchPokemonDetailsUseCase()) {
        self.detailsUrl = detailsUrl
        self.detailsUseCase = detailsUseCase
    }
    
    func fetchDetails() {
        viewState = .loading
        
        Task {
            do {
                let response = try await self.detailsUseCase.execute(endpoint: detailsUrl)
                
                let types = response.types?.map({ $0.lowercased().capitalized })
                let pairs = stride(from: 0, to: types?.count ?? 0, by: 2).map { i in
                    Array(types?[i ..< min(i + 2, types?.count ?? 0)] ?? [])
                }
                
                let info = DetailsInfo(name: response.name?.lowercased().capitalized,
                                       height: "\(DetailsString.heightTitle.localized) \((Double(response.height ?? 0)/10.0).formatted())m",
                                       weight: "\(DetailsString.weightTitle.localized) \((Double(response.weight ?? 0)/10.0).formatted())kg",
                                       image: response.image,
                                       types: pairs
                )
                
                viewState = .success(info)
            } catch(let error) {
                viewState = .error(error as? NetworkError ?? .unknown(error: nil, statusCode: nil))
            }
        }
    }
}
