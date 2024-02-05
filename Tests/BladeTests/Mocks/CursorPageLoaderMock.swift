//
// Blade
// Copyright © 2024 Space Code. All rights reserved.
//

import Blade

final class CursorPageLoaderMock<T: Equatable & Decodable & Identifiable>: ICursorPageLoader {
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
