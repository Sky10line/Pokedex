import SwiftUI

struct DetailsView<ViewModel: DetailsViewModelProtocol>: View {
    @ObservedObject private var viewModel: ViewModel
    
    public init(viewModel: ViewModel) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            switch viewModel.viewState {
            case .none:
                EmptyView()
            case .loading:
                loadingView()
            case .success(let details):
                sucessView(details: details)
            case .error(let networkError):
                errorView(error: networkError)
            }
        }.onAppear() {
            self.viewModel.fetchDetails()
        }
    }
    
    func loadingView() -> some View {
        VStack {
            ProgressView()
            Text(DetailsString.loading.localized)
        }
    }
    
    func errorView(error: NetworkError) -> some View {
        VStack(spacing: 24) {
            Spacer()
            Text("\(error.errorDescription ?? "")\n\(DetailsString.error.localized)")
                .multilineTextAlignment(.center)
            Spacer()
            
            Button(action: {
                self.viewModel.fetchDetails()
            }, label: {
                HStack {
                    Spacer()
                    Text(DetailsString.retryButton.localized)
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
    
    func sucessView(details: DetailsInfo) -> some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: details.image ?? "")) { image in
                    image
                        .resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 200, height: 200)
                .background(Color.gray)
                .clipShape(Circle())
                .padding(.top, 32)
                .accessibilityIdentifier(AccessibilityID.Details.pokemonImage)
                .accessibilityElement(children: .ignore)
                
                Text(details.name ?? "")
                    .font(.largeTitle)
                    .accessibilityIdentifier(AccessibilityID.Details.nameLabel)
                
                VStack(spacing: 16) {
                    Text(DetailsString.infosTitle.localized)
                        .font(.title2)
                        .padding(.top, 16)
                        .accessibilityIdentifier(AccessibilityID.Details.informationLabel)
                    
                    infoPairView(firstLabel: details.height ?? "", secondLabel: details.weight ?? "")
                        .padding(.bottom, 16)
                        .accessibilityIdentifier(AccessibilityID.Details.physicalInfos)
                }
                .contentMargins(16)
                .background(Color.gray.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.horizontal, 16)
                
                VStack(spacing: 16) {
                    Text(DetailsString.typesTitle.localized)
                        .font(.title3)
                        .padding(.top, 16)
                        .accessibilityIdentifier(AccessibilityID.Details.typesLabel)
                    
                    typesView(types: details.types ?? [])
                        .padding(.bottom, 16)
                        .accessibilityIdentifier(AccessibilityID.Details.typesInfo)
                }
                .contentMargins(16)
                .background(Color.gray.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.horizontal, 16)
                .padding(.vertical, 24)
                
                Spacer()
            }
        }
    }
    
    func typesView(types: [[String]]) -> some View {
        ForEach(types, id: \.self) { pair in
            infoPairView(firstLabel: pair[safe: 0] ?? "", secondLabel: pair[safe: 1] ?? "")
        }
    }
    
    func infoPairView(firstLabel: String, secondLabel: String) -> some View {
        HStack {
            Spacer()
            Text(firstLabel)
            Spacer()
            Text(secondLabel)
            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        DetailsView(viewModel: DetailsViewModel(detailsUrl: "pokemon/4/"))
    }
}
