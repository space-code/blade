//
// Blade
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

struct TestItem: Equatable, Identifiable {
    // MARK: Properties

    let id: UUID

    // MARK: Initialization

    init(id: UUID = UUID()) {
        self.id = id
    }
}
