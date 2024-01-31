//
// Blade
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

public struct CursorPaginationRequest<T: Identifiable>: Equatable {
    // MARK: Properties

    public let id: T.ID
}
