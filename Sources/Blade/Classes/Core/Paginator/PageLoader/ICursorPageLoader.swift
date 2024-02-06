//
// Blade
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

public protocol ICursorPageLoader<Element> {
    /// The type of elements the paginator is handling, which must conform to `Decodable` & `Equatable`.
    associatedtype Element: Decodable & Equatable & Identifiable

    /// Loads a page of elements based on the provided pagination request asynchronously.
    ///
    /// - Parameters:
    ///   - request: A `LimitPageRequest` specifying the limit and offset for the requested page.
    ///
    /// - Returns: An asynchronous task representing the loading process, resolving to a `Page` of elements.
    func loadPage(request: CursorPaginationRequest<Element>) async throws -> Page<Element>
}
