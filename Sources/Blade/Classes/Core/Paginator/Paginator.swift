//
// Blade
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

// MARK: - Paginator

/// Paginator is an actor responsible for paginating and loading data using a provided paginator service.
public actor Paginator<T: Decodable & Equatable> {
    // MARK: Types

    /// Enum representing errors that may occur during pagination.
    public enum Error: Swift.Error {
        case alreadyLoading
    }

    // MARK: Properties

    /// Internal flag to track whether the paginator is currently loading data.
    private var isLoadingInternal = false

    /// Public property to check if the paginator is currently loading.
    private(set) var isLoading: Bool {
        get { Task.isCancelled || isLoadingInternal }
        set { isLoadingInternal = newValue }
    }

    /// An array to store the loaded elements.
    public private(set) var elements: [T] = []

    private let paginationStrategy: any IPaginationStrategy<T>

    // MARK: Initialization

    /// Initializes the Paginator with the provided first page number and paginator service.
    public init(
        configuration: PaginationLimitOffset,
        offsetPageLoader: any IOffsetPageLoader<T>
    ) {
        paginationStrategy = LimitOffsetStrategy(
            configuration: configuration,
            pageLoader: offsetPageLoader
        )
    }

    public init(
        configuration: PaginationCursorSeek<T>,
        cursorPageLoader: any ICursorPageLoader<T>
    ) where T: Identifiable {
        paginationStrategy = CursorSeekStrategy(
            configuration: configuration,
            pageLoader: cursorPageLoader
        )
    }

    // MARK: Private

    private func perform(_ task: @autoclosure () async throws -> Page<T>) async throws -> Page<T> {
        guard !isLoadingInternal else { throw Error.alreadyLoading }

        isLoadingInternal = true
        defer { isLoadingInternal = false }

        return try await task()
    }
}

// MARK: IPaginator

extension Paginator: IPaginator {
    public func refresh() async throws -> Page<T> {
        try await perform(
            await {
                let page = try await paginationStrategy.refresh()
                elements = page.items
                return page
            }()
        )
    }

    public func loadNextPage() async throws -> Page<T> {
        try await perform(
            await {
                let page = try await paginationStrategy.loadNextPage()
                elements += page.items
                return page
            }()
        )
    }

    public func reset() async {
        await paginationStrategy.reset()
        elements = []
        isLoadingInternal = false
    }
}
