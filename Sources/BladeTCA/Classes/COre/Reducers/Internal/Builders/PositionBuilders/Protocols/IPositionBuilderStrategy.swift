//
// Blade
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

/// This protocol defines the interface for a strategy used in building positions based on a given state.
protocol IPositionBuilderStrategy<State, PositionType> {
    associatedtype State: Equatable
    associatedtype PositionType: Equatable

    /// Takes a state as input and returns the corresponding position.
    ///
    /// - Parameter state: The state for which the next position needs to be built.
    ///
    /// - Returns:  The resulting position based on the provided state.
    func next(state: State) -> PositionType
}
