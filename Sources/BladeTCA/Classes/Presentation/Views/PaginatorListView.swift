//
// Blade
// Copyright © 2024 Space Code. All rights reserved.
//

import BladeTCA
import ComposableArchitecture
import SwiftUI

// MARK: - PaginatorListView

public struct PaginatorListView<
    State: Equatable & Identifiable,
    Action: Equatable,
    Header: View,
    Body: View,
    Footer: View,
    PositionType: Equatable,
    Request: Equatable
>: View {
    // MARK: Types

    private typealias StoreType = ViewStoreOf<PaginatorReducer<State, Action, PositionType, Request>>

    @SwiftUI.State private var isLoading = false

    // MARK: Properties

    public let store: Store<PaginatorState<State, PositionType>, PaginatorAction<State, Action, Request>>
    public let header: () -> Header
    public let content: (State) -> Body
    public let footer: () -> Footer

    public init(
        store: Store<PaginatorState<State, PositionType>, PaginatorAction<State, Action, Request>>,
        @ViewBuilder header: @escaping () -> Header,
        @ViewBuilder content: @escaping (State) -> Body,
        @ViewBuilder footer: @escaping () -> Footer
    ) {
        self.store = store
        self.header = header
        self.content = content
        self.footer = footer
    }

    // MARK: View

    public var body: some View {
        List {
            Section {
                header()
            }

            WithViewStore(store, observe: { $0 }) { (viewStore: StoreType) in
                Section(content: {
                    ForEach(viewStore.items) { item in
                        content(item)
                            .onAppear {
                                viewStore.send(.itemAppeared(item.id))
                            }
                    }
                })
            }

            Section {
                footer()
            }

            Section {
                EmptyView()
                    .modifier(LoadingViewModifier(isLoading: isLoading))
            }
        }
    }
}

public extension PaginatorListView where Header == EmptyView, Footer == EmptyView {
    init(
        store: Store<PaginatorState<State, PositionType>, PaginatorAction<State, Action, Request>>,
        @ViewBuilder content: @escaping (State) -> Body
    ) {
        self.init(store: store, header: { EmptyView() }, content: content, footer: { EmptyView() })
    }
}

public extension PaginatorListView where Header: View, Footer == EmptyView {
    init(
        store: Store<PaginatorState<State, PositionType>, PaginatorAction<State, Action, Request>>,
        header: @escaping () -> Header,
        @ViewBuilder content: @escaping (State) -> Body
    ) {
        self.init(store: store, header: header, content: content, footer: { EmptyView() })
    }
}
