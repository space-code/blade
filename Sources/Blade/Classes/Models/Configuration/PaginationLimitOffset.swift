//
// Blade
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

public struct PaginationLimitOffset {
    // MARK: Properties

    public let firstPage: Int
    public let limit: Int

    // MARK: Initialization

    public init(firstPage: Int, limit: Int) {
        self.firstPage = firstPage
        self.limit = limit
    }
}
