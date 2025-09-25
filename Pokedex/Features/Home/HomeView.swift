import SwiftUI

struct HomeView<ViewModel: HomeViewModelProtocol>: View {
    @ObservedObject private var viewModel: ViewModel
    
    public init(viewModel: ViewModel) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
        self.viewModel.fetchList()
    }
    
    var body: some View {
        
        ZStack {
            switch viewModel.viewState {
            case .none:
                EmptyView()
            case .loading:
                loadingView()
            case .success(let items):
                sucessView(items: items)
            case .error(let networkError):
                errorView(error: networkError)
            }
        }
    }
    
    func loadingView() -> some View {
        VStack {
            ProgressView()
            Text(HomeStrings.loading.localized)
        }
    }
    
    func errorView(error: NetworkError) -> some View {
        VStack(spacing: 24) {
            Spacer()
            Text("\(error.errorDescription ?? "")\n\(HomeStrings.error.localized)")
                .multilineTextAlignment(.center)
            Spacer()
            
            Button(action: {
                self.viewModel.fetchList()
            }, label: {
                HStack {
                    Spacer()
                    Text(HomeStrings.retryButton.localized)
                        .tint(Color.white)
                        .padding(.vertical)
                    Spacer()
                }
                .background(Color.blue)
                .clipShape(Capsule())
            })
            .padding()
        }
        
    }
    
    func sucessView(items: [HomeItemModel]) -> some View {
        VStack {
            List {
                ForEach(items, id: \.self) { item in
                    NavigationLink(destination: DetailsBuilder.make(detailsUrl: item.detailURI)) {
                        Text(item.name)
                    }.onAppear {
                        Task {
                            await self.viewModel.loadMoreItemsIfNeeded(currentItem: item)
                        }
                    }
                }
                
                if self.viewModel.hasMoreItems {
                    HStack {
                        Spacer()
                        ProgressView().id(UUID())
                            .scaleEffect(1.5)
                        Spacer()
                    }.listRowBackground(Color.clear)
                }
            }
            .accessibilityIdentifier(AccessibilityID.Home.pokemonList)
            .navigationTitle(HomeStrings.title.localized)
            .refreshable {
                await self.viewModel.refreshList()
            }
            
        }
        
    }
}

#Preview {
    NavigationStack {
        HomeView(viewModel: HomeViewModel())
    }
}
