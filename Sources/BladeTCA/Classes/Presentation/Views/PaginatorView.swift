//
// Blade
// Copyright © 2024 Space Code. All rights reserved.
//

import BladeTCA
import ComposableArchitecture
import SwiftUI

// MARK: - PaginatorView

public struct PaginatorView<
    State: Equatable & Identifiable,
    Action: Equatable,
    PositionType: Equatable,
    Request: Equatable,
    Body: View,
    RowContent: View
>: View {
    // MARK: Types

    private typealias StoreType = ViewStoreOf<PaginatorReducer<State, Action, PositionType, Request>>

    // MARK: Properties

    public let store: Store<PaginatorState<State, PositionType>, PaginatorAction<State, Action, Request>>
    public let content: ([State], @escaping (State) -> AnyView) -> Body
    public let rowContent: (State) -> RowContent

    // MARK: Initialization

    public init(
        store: Store<PaginatorState<State, PositionType>, PaginatorAction<State, Action, Request>>,
        @ViewBuilder content: @escaping ([State], @escaping (State) -> AnyView) -> Body,
        @ViewBuilder rowContent: @escaping (State) -> RowContent
    ) {
        self.store = store
        self.content = content
        self.rowContent = rowContent
    }

    // MARK: View

    public var body: some View {
        WithViewStore(store, observe: { $0 }) { (viewStore: StoreType) in
            content(viewStore.items.elements) { item in
                rowContent(item)
                    .onAppear { viewStore.send(.itemAppeared(item.id)) }
                    .any
            }
            .modifier(LoadingViewModifier(isLoading: viewStore.isLoading && !viewStore.items.isEmpty))
        }
    }
}

// MARK: Extension

private extension View {
    var any: AnyView {
        AnyView(self)
    }
}
