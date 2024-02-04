//
// Blade
// Copyright © 2024 Space Code. All rights reserved.
//

import Blade

/// A offset-based paginator position builder.
struct OffsetPositionBuilderStrategy<State: Equatable & Identifiable>: IPositionBuilderStrategy {
    /// Creates a next position.
    ///
    /// - Parameter state: The current state of the paginator.
    ///
    /// - Returns: The next position offset based on the strategy.
    func next(state: PaginatorState<State, Int>) -> Int {
        state.items.count
    }
}
