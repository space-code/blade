//
// Blade
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

public struct PaginationCursorSeek<T: Identifiable> {
    // MARK: Properties

    public let id: T.ID

    // MARK: Initialization

    public init(id: T.ID) {
        self.id = id
    }
}
