//
// Blade
// Copyright © 2024 Space Code. All rights reserved.
//

import Blade
import Foundation

/// A request builder strategy for offset-based pagination.
struct OffsetRequestBuilderStrategy<State: Equatable & Identifiable>: IRequestBuilderStrategy {
    // MARK: Properties

    /// The maximum number of items to be included in the pagination request.
    private let limit: Int

    // MARK: Initialization

    /// Initializes the OffsetRequestBuilderStrategy with a specified limit.
    ///
    /// - Parameter limit: The maximum number of items to be included in each pagination request.
    init(limit: Int) {
        self.limit = limit
    }

    // MARK: IRequestBuilderStrategy

    /// Constructs a pagination request based on the provided state.
    ///
    /// - Parameter state: The current state of the paginator.
    ///
    /// - Returns: An OffsetPaginationRequest with the offset position and specified limit from the provided state.
    func makeRequest(state: PaginatorState<State, Int>) -> OffsetPaginationRequest {
        OffsetPaginationRequest(limit: limit, offset: state.position)
    }
}
