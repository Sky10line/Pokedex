import SwiftUI

@MainActor
enum DetailsBuilder {
    static func make(detailsUrl: String) -> some View {
        let viewModel = DetailsViewModel(detailsUrl: detailsUrl)
        return self.make(viewModel: viewModel)
    }
    
    static func make(viewModel: some DetailsViewModelProtocol) -> some View {
        return DetailsView(viewModel: viewModel)
    }
}
