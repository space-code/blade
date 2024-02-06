//
// Blade
// Copyright © 2024 Space Code. All rights reserved.
//

import ComposableArchitecture
import Foundation

// MARK: - OffsetPaginatorState

/// Represents the state of a paginator for cursor-based pagination.
public struct PaginatorState<State: Equatable & Identifiable, T: Equatable>: Equatable, IPaginatorState {
    // MARK: Properties

    /// The array of identifiable items managed by the paginator.
    public var items: IdentifiedArrayOf<State>

    /// A Boolean value indicating whether the paginator is currently loading more data.
    var isLoading: Bool

    /// The offset or position in the data set from where the paginator should load more items.
    var position: T

    /// A Boolean value indicating whether there is more data available to be loaded.
    var hasMoreData: Bool

    // MARK: Initialization

    /// Initializes a paginator state with an array of identifiable items.
    ///
    /// - Parameters:
    ///   - items: The array of identifiable items to be managed by the paginator.
    public init(items: IdentifiedArrayOf<State>, position: T) {
        self.items = items
        isLoading = false
        hasMoreData = true
        self.position = position
    }
}
