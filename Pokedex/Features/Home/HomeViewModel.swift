import Foundation
import SwiftUICore

@MainActor
protocol HomeViewModelProtocol: ObservableObject {
    var viewState: LoadingState<[HomeItemModel]> { get }
    var isLoadingMore: Bool { get }
    var hasMoreItems: Bool { get }
    
    func fetchList()
    func refreshList() async
    func loadMoreItemsIfNeeded(currentItem: HomeItemModel) async
}

final class HomeViewModel: HomeViewModelProtocol {
    @Published public var viewState: LoadingState<[HomeItemModel]> = .none
    @Published public var isLoadingMore: Bool = false
    @Published public var hasMoreItems: Bool = false
    
    private let listUseCase: FetchPokemonListUseCase
    private var data: PokemonList = .init(total: 0, offset: 0, items: [])
    private let numberOfItems = 20
    
    init(listUseCase: FetchPokemonListUseCase = FetchPokemonListUseCase()) {
        self.listUseCase = listUseCase
    }
    
    func fetchList() {
        viewState = .loading
        Task {
            await refreshList()
        }
    }
    
    func refreshList() async {
        data.total = 0
        data.offset = 0
        data.items = []
        
        await fetchPokemonList(currentData: data)
    }
    
    func loadMoreItemsIfNeeded(currentItem: HomeItemModel) async {
        guard !isLoadingMore && hasMoreItems else { return }

        if currentItem.name.lowercased() == data.items.last?.name.lowercased() {
            await loadMoreItems()
        }
    }
    
    func loadMoreItems() async {
        self.isLoadingMore = true
        defer { self.isLoadingMore = false }

        await fetchPokemonList(currentData: data)
    }
    
    func fetchPokemonList(currentData: PokemonList) async {
        do {
            let response = try await self.listUseCase.execute(numberOfItems: self.numberOfItems, currentData: currentData)
            self.data = response
            self.hasMoreItems = data.total > data.offset
            
            self.viewState = .success(data.items.map({ HomeItemModel(name: $0.name.lowercased().capitalized, detailURI: $0.detailURI) }))
        } catch(let error) {
            self.viewState = .error(error as? NetworkError ?? .unknown(error: nil, statusCode: nil))
        }
    }
}
