//
// Blade
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

// MARK: - LimitOffsetStrategy

actor LimitOffsetStrategy<Element: Decodable & Equatable> {
    // MARK: Properties

    private let configuration: PaginationLimitOffset
    private let pageLoader: any IOffsetPageLoader<Element>

    private var currentPage: Int

    // MARK: Initialization

    init(configuration: PaginationLimitOffset, pageLoader: any IOffsetPageLoader<Element>) {
        self.configuration = configuration
        self.pageLoader = pageLoader
        currentPage = configuration.firstPage
    }
}

// MARK: IPaginationStrategy

extension LimitOffsetStrategy: IPaginationStrategy {
    func refresh() async throws -> Page<Element> {
        currentPage = configuration.firstPage
        let page = try await pageLoader.loadPage(request: OffsetPaginationRequest(limit: configuration.limit, offset: .zero))
        currentPage += 1
        return page
    }

    func loadNextPage() async throws -> Page<Element> {
        let page = try await pageLoader.loadPage(request: OffsetPaginationRequest(
            limit: configuration.limit,
            offset: configuration.limit * (currentPage + 1)
        ))
        currentPage += 1
        return page
    }

    func reset() async {}
}
