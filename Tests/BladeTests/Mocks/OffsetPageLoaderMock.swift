//
// Blade
// Copyright © 2024 Space Code. All rights reserved.
//

import Blade

final class OffsetPageLoaderMock<T: Equatable & Decodable>: IOffsetPageLoader {
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
