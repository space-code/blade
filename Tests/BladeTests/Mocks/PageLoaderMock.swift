//
// Blade
// Copyright © 2024 Space Code. All rights reserved.
//

import Blade

final class PageLoaderMock<T: Equatable & Decodable>: IPageLoader {
    var invokedLoadPage = false
    var invokedLoadPageCount = 0
    var invokedLoadPageParameters: (request: LimitPageRequest, Void)?
    var invokedLoadPageParametersList = [(request: LimitPageRequest, Void)]()
    var stubbedLoadPage: Page<T>!

    func loadPage(request: LimitPageRequest) async throws -> Page<T> {
        invokedLoadPage = true
        invokedLoadPageCount += 1
        invokedLoadPageParameters = (request, ())
        invokedLoadPageParametersList.append((request, ()))
        return stubbedLoadPage
    }
}
