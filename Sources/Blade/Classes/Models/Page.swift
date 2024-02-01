//
// Blade
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

/// A generic struct representing a paginated collection of items.
public struct Page<T: Equatable>: Equatable {
    // MARK: Properties

    /// An array of items of generic type T contained in the current page.
    public let items: [T]

    /// A boolean flag indicating whether there are more data available beyond
    /// the current page.
    public let hasMoreData: Bool

    // MARK: Initialization

    /// Creates a `Page` instance.
    ///
    /// - Parameters:
    ///   - items: An array of items of generic type T contained in the current page.
    ///   - hasMoreData: A boolean flag indicating whether there are more data available beyond the current page.
    public init(items: [T], hasMoreData: Bool) {
        self.items = items
        self.hasMoreData = hasMoreData
    }
}
