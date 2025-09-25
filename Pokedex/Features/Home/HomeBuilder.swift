import SwiftUI

@MainActor
enum HomeBuilder {
    static func make() -> some View {
        let viewModel = HomeViewModel()
        return self.make(viewModel: viewModel)
    }
    
    static func make(viewModel: some HomeViewModelProtocol) -> some View {
        return HomeView(viewModel: viewModel)
    }
}
