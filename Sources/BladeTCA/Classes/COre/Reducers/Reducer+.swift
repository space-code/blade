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
    ///   - state: The key path to the paginator state within the larger state.
    ///   - action: The case path to the paginator actions within the larger action enum.
    ///   - loadPage: A closure to load a page of items based on the provided `LimitPageRequest` and current state.
    ///
    /// - Returns: A reducer for integrating the paginator functionality.
    func paginator<ItemState: Equatable & Identifiable>(
        limit: Int = 20,
        state: WritableKeyPath<State, PaginatorState<ItemState>>,
        action: AnyCasePath<Action, PaginatorAction<ItemState, Never>>,
        loadPage: @Sendable @escaping (LimitPageRequest, State) async throws -> Page<ItemState>
    ) -> some Reducer<State, Action> {
        PaginatorIntegrationReducer(
            limit: limit,
            parent: self,
            childState: state,
            childAction: action,
            loadPage: loadPage
        )
    }
}
