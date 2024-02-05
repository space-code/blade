//
// Blade
// Copyright © 2024 Space Code. All rights reserved.
//

import ComposableArchitecture

protocol IPaginatorState {
    associatedtype Element: Equatable & Identifiable

    var items: IdentifiedArrayOf<Element> { get set }
    var isLoading: Bool { get set }
    var hasMoreData: Bool { get set }
}
