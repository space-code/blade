//
// Blade
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

/// A protocol for defining request builder strategies in a paginator.
protocol IRequestBuilderStrategy<State, Request>: Sendable {
    /// The state type associated with the strategy, conforming to Equatable.
    associatedtype State: Equatable

    /// The request type associated with the strategy, conforming to Equatable.
    associatedtype Request: Equatable & Sendable

    /// Makes a request.
    ///
    /// - Parameter state: The current state for which a request needs to be built.
    ///
    /// - Returns: The constructed request based on the provided state.
    func makeRequest(state: State) -> Request
}
