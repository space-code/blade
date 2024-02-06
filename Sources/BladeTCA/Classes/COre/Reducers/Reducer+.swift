//
// Blade
// Copyright © 2024 Space Code. All rights reserved.
//

import Blade
import ComposableArchitecture

// MARK: - Reducer Extension for Paginator Integration

/// An extension on the `Reducer` type providing a method for integrating a paginator into a Composable Architecture.
public extension Reducer {
    /// Integrates a paginator into a Composable Architecture, facilitating paginated data loading.
    ///
    /// - Parameters:
    ///   - limit: The number of items to load per page, with a default value of 20.
    ///   - state: The key path to the paginator state.
    ///   - action: The case path to the paginator actions.
    ///   - loadPage: A closure to load a page of items based on the provided `LimitPageRequest` and current state.
    ///
    /// - Returns: A reducer for integrating the paginator functionality.
    func paginator<ItemState: Equatable & Identifiable>(
        limit: Int = 20,
        state: WritableKeyPath<State, PaginatorState<ItemState, Int>>,
        action: AnyCasePath<Action, PaginatorAction<ItemState, Never, OffsetPaginationRequest>>,
        loadPage: @Sendable @escaping (OffsetPaginationRequest, State) async throws -> Page<ItemState>
    ) -> some Reducer<State, Action> {
        PaginatorIntegrationReducer(
            parent: self,
            childState: state,
            childAction: action,
            loadPage: loadPage,
            requestBuilderStrategy: OffsetRequestBuilderStrategy(limit: limit),
            positionBuilderStrategy: OffsetPositionBuilderStrategy()
        )
    }

    /// Integrates a paginator into a Composable Architecture, facilitating paginated data loading with cursor-based pagination.
    ///
    /// - Parameters:
    ///   - state: The key path to the paginator state.
    ///   - action: The case path to the paginator actions.
    ///   - loadPage: A closure to load a page of items based on the provided `CursorPaginationRequest` and current state.
    ///
    /// - Returns: A reducer for integrating the paginator functionality.
    func paginator<ItemState: Equatable & Identifiable>(
        state: WritableKeyPath<State, PaginatorState<ItemState, ItemState.ID>>,
        action: AnyCasePath<Action, PaginatorAction<ItemState, Never, CursorPaginationRequest<ItemState>>>,
        loadPage: @Sendable @escaping (CursorPaginationRequest<ItemState>, State) async throws -> Page<ItemState>
    ) -> some Reducer<State, Action> {
        PaginatorIntegrationReducer(
            parent: self,
            childState: state,
            childAction: action,
            loadPage: loadPage,
            requestBuilderStrategy: CursorRequestBuilderStrategy(),
            positionBuilderStrategy: CursorPositionBuilderStrategy()
        )
    }
}
