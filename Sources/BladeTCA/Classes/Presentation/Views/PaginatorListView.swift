//
// Blade
// Copyright © 2024 Space Code. All rights reserved.
//

import BladeTCA
import ComposableArchitecture
import SwiftUI

public struct PaginatorListView<State: Equatable & Identifiable, Action: Equatable, Body: View>: View {
    // MARK: Properties

    public let store: Store<PaginatorState<State>, PaginatorAction<State, Action>>
    public let content: (State) -> Body

    public init(
        store: Store<PaginatorState<State>, PaginatorAction<State, Action>>,
        content: @escaping (State) -> Body
    ) {
        self.store = store
        self.content = content
    }

    // MARK: View

    public var body: some View {
        WithViewStore(store, observe: { $0 }) { (viewStore: ViewStoreOf<PaginatorReducer<State, Action>>) in
            List(viewStore.items) { item in
                content(item)
                    .onAppear {
                        viewStore.send(.itemAppeared(item.id))
                    }
            }
            .modifier(LoadingViewModifier(isLoading: viewStore.isLoading && !viewStore.items.isEmpty))
        }
    }
}
