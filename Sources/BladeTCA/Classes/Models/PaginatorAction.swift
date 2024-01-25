//
// Blade
// Copyright © 2024 Space Code. All rights reserved.
//

import Blade
import ComposableArchitecture
import Foundation

/// Represents the actions that can be performed on a paginator in a Composable Architecture.
///
/// - Parameters:
///   - State: The type of state managed by the paginator.
///   - Action: The type of actions that can be associated with the paginator.
public enum PaginatorAction<State: Equatable & Identifiable, Action: Equatable>: Equatable {
    // MARK: Action Cases

    /// Indicates that an item with the specified identifier has appeared in the UI.
    case itemAppeared(State.ID)

    /// Represents a request to load the next page of items using the provided `LimitPageRequest`.
    case requestPage(LimitPageRequest)

    /// Represents the response to a page request, containing the result of the operation.
    case response(TaskResult<Page<State>>)
}
