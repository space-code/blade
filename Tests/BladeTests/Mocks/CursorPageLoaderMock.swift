//
// Blade
// Copyright © 2024 Space Code. All rights reserved.
//

import Blade

// `@unchecked Sendable`: the mock is only mutated sequentially from tests.
final class CursorPageLoaderMock<T: Equatable & Decodable & Identifiable & Sendable>: ICursorPageLoader, @unchecked Sendable where T.ID: Sendable {
    var invokedLoadPage = false
    var invokedLoadPageCount = 0
    var invokedLoadPageParameters: (request: CursorPaginationRequest<T>, Void)?
    var invokedLoadPageParametersList = [(request: CursorPaginationRequest<T>, Void)]()
    var stubbedLoadPage: Page<T>!

    func loadPage(request: CursorPaginationRequest<T>) async throws -> Page<T> {
        invokedLoadPage = true
        invokedLoadPageCount += 1
        invokedLoadPageParameters = (request, ())
        invokedLoadPageParametersList.append((request, ()))
        return stubbedLoadPage
    }
}
