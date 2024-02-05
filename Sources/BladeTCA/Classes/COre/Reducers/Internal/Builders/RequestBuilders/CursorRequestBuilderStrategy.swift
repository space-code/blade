//
// Blade
// Copyright © 2024 Space Code. All rights reserved.
//

import Blade

/// A request builder strategy for cursor-based pagination.
struct CursorRequestBuilderStrategy<State: Equatable & Identifiable>: IRequestBuilderStrategy {
    // MARK: IRequestBuilderStrategy

    /// Constructs a pagination request based on the provided state.
    ///
    /// - Parameter state: The current state of the paginator.
    ///
    /// - Returns: A CursorPaginationRequest with the cursor position from the provided state.
    func makeRequest(state: PaginatorState<State, State.ID>) -> CursorPaginationRequest<State> {
        CursorPaginationRequest(id: state.position)
    }
}
