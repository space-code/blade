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
    Header: View,
    Body: View,
    Footer: View,
    RowContent: View
>: View {
    // MARK: Types

    private typealias StoreType = ViewStoreOf<PaginatorReducer<State, Action, PositionType, Request>>

    // MARK: Properties

    public let store: Store<PaginatorState<State, PositionType>, PaginatorAction<State, Action, Request>>
    public let header: () -> Header
    public let content: ([State], @escaping (State) -> AnyView) -> Body
    public let footer: () -> Footer
    public let rowContent: (State) -> RowContent

    // MARK: Initialization

    public init(
        store: Store<PaginatorState<State, PositionType>, PaginatorAction<State, Action, Request>>,
        @ViewBuilder header: @escaping () -> Header,
        @ViewBuilder content: @escaping ([State], @escaping (State) -> AnyView) -> Body,
        @ViewBuilder footer: @escaping () -> Footer,
        @ViewBuilder rowContent: @escaping (State) -> RowContent
    ) {
        self.store = store
        self.header = header
        self.content = content
        self.footer = footer
        self.rowContent = rowContent
    }

    // MARK: View

    public var body: some View {
        WithViewStore(store, observe: { $0 }) { (viewStore: StoreType) in
            header()

            content(viewStore.items.elements) { item in
                rowContent(item)
                    .onAppear { viewStore.send(.itemAppeared(item.id)) }
                    .any
            }
            .modifier(LoadingViewModifier(isLoading: viewStore.isLoading && !viewStore.items.isEmpty))

            footer()
        }
    }
}

public extension PaginatorView where Header == EmptyView, Footer == EmptyView {
    init(
        store: Store<PaginatorState<State, PositionType>, PaginatorAction<State, Action, Request>>,
        @ViewBuilder content: @escaping ([State], @escaping (State) -> AnyView) -> Body,
        @ViewBuilder rowContent: @escaping (State) -> RowContent
    ) {
        self.init(store: store, header: { EmptyView() }, content: content, footer: { EmptyView() }, rowContent: rowContent)
    }
}

public extension PaginatorView where Header: View, Footer == EmptyView {
    init(
        store: Store<PaginatorState<State, PositionType>, PaginatorAction<State, Action, Request>>,
        header: @escaping () -> Header,
        @ViewBuilder content: @escaping ([State], @escaping (State) -> AnyView) -> Body,
        @ViewBuilder rowContent: @escaping (State) -> RowContent
    ) {
        self.init(store: store, header: header, content: content, footer: { EmptyView() }, rowContent: rowContent)
    }
}

// MARK: Extension

private extension View {
    var any: AnyView {
        AnyView(self)
    }
}
