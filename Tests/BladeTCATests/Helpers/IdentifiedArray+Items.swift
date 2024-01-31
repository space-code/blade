//
// Blade
// Copyright © 2024 Space Code. All rights reserved.
//

import ComposableArchitecture
import Foundation

extension IdentifiedArray where Element == TestItem, ID == UUID {
    static func items(count: Int) -> IdentifiedArray<ID, Element> {
        let elements: [Element] = Array(0 ..< count).map { _ in Element() }
        return IdentifiedArray(uniqueElements: elements)
    }
}
