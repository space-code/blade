//
// Blade
// Copyright © 2024 Space Code. All rights reserved.
//

import Blade
@testable import BladeTCA
import ComposableArchitecture
import XCTest

// MARK: - PaginatorReducerTests

@MainActor
final class PaginatorReducerTests: XCTestCase {
    // MARK: Types

    private typealias PaginatorAction = BladeTCA.PaginatorAction<TestItem, Never>

    // MARK: Tests

    func test_thatPaginatorRequestsNextPage_whenLastItemDidAppear() async {
        let items: IdentifiedArray<UUID, TestItem> = .items(count: .limit)

        let store = TestStore(initialState: PaginatorReducer<TestItem, PaginatorAction>.State(items: items)) {
            PaginatorReducer<TestItem, PaginatorAction>(limit: .limit)
        }

        await store.send(.itemAppeared(items[.limit - 1].id)) {
            $0.isLoading = true
        }

        await store.receive(.requestPage(OffsetPaginationRequest(limit: .limit, offset: .limit)))
    }

    func test_thatPaginatorDoesNotRequestNextPage_whenLastItemDidNotAppear() async {
        let items: IdentifiedArray<UUID, TestItem> = .items(count: .limit)

        let store = TestStore(initialState: PaginatorReducer<TestItem, PaginatorAction>.State(items: items)) {
            PaginatorReducer<TestItem, PaginatorAction>(limit: .limit)
        }

        await store.send(.itemAppeared(items[0].id))
    }
}

// MARK: - Constants

private extension Int {
    static let limit = 10
}

/// https://engineering.monstar-lab.com/en/post/2023/10/26/The-Composable-architecture-and-TDD/
