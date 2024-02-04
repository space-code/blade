//
// Blade
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

/// A cursor-based paginator position builder.
struct CursorPositionBuilderStrategy<State: Equatable & Identifiable>: IPositionBuilderStrategy {
    /// Creates a next position.
    ///
    /// - Parameter state: The current state of the paginator.
    ///
    /// - Returns: The next position offset based on the strategy.
    func next(state: PaginatorState<State, State.ID>) -> State.ID {
        state.items.last?.id ?? state.position
    }
}
