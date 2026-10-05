//
// Blade
// Copyright © 2024 Space Code. All rights reserved.
//

import Blade

// `@unchecked Sendable`: the mock is only mutated sequentially from tests.
final class OffsetPageLoaderMock<T: Equatable & Decodable & Sendable>: IOffsetPageLoader, @unchecked Sendable {
    var invokedLoadPage = false
    var invokedLoadPageCount = 0
    var invokedLoadPageParameters: (request: OffsetPaginationRequest, Void)?
    var invokedLoadPageParametersList = [(request: OffsetPaginationRequest, Void)]()
    var stubbedLoadPage: Page<T>!

    func loadPage(request: OffsetPaginationRequest) async throws -> Page<T> {
        invokedLoadPage = true
        invokedLoadPageCount += 1
        invokedLoadPageParameters = (request, ())
        invokedLoadPageParametersList.append((request, ()))
        return stubbedLoadPage
    }
}
