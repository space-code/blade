//
// Blade
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

// MARK: - CursorSeekStrategy

actor CursorSeekStrategy<Element: Decodable & Equatable & Identifiable> {
    // MARK: Properties

    private let configuration: PaginationCursorSeek<Element>
    private let pageLoader: any ICursorPageLoader<Element>

    private var id: Element.ID

    // MARK: Initialization

    init(
        configuration: PaginationCursorSeek<Element>,
        pageLoader: any ICursorPageLoader<Element>
    ) {
        self.configuration = configuration
        self.pageLoader = pageLoader
        id = configuration.id
    }
}

// MARK: IPaginationStrategy

extension CursorSeekStrategy: IPaginationStrategy {
    func refresh() async throws -> Page<Element> {
        let page = try await pageLoader.loadPage(request: CursorPaginationRequest(id: id))
        return page
    }

    func loadNextPage() async throws -> Page<Element> {
        let page = try await pageLoader.loadPage(request: CursorPaginationRequest(id: id))

        guard let lastID = page.items.last?.id else {
            throw URLError(.unknown)
        }

        id = lastID

        return page
    }

    func reset() async {
        id = configuration.id
    }
}
