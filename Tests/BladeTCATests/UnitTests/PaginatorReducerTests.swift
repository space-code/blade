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

    private typealias PaginatorAction = BladeTCA.PaginatorAction<TestItem, Never, OffsetPaginationRequest>

    // MARK: Tests

    func test_thatPaginatorOffsetRequestsNextPage_whenLastItemDidAppear() async {
        let items: IdentifiedArray<UUID, TestItem> = .items(count: .limit)

        let store = TestStore(
            initialState: PaginatorReducer<TestItem, PaginatorAction, Int, OffsetPaginationRequest>.State(
                items: items, position: .limit
            )
        ) {
            PaginatorReducer<TestItem, PaginatorAction, Int, OffsetPaginationRequest>(
                requestBuilder: OffsetRequestBuilderStrategy(limit: .limit),
                positionBuilder: OffsetPositionBuilderStrategy()
            )
        }

        await store.send(.itemAppeared(items[.limit - 1].id)) {
            $0.isLoading = true
        }

        await store.receive(.requestPage(OffsetPaginationRequest(limit: .limit, offset: .limit)))
    }

    func test_thatPaginatorOffsetDoesNotRequestNextPage_whenLastItemDidNotAppear() async {
        let items: IdentifiedArray<UUID, TestItem> = .items(count: .limit)

        let store = TestStore(initialState: PaginatorReducer<TestItem, PaginatorAction, Int, OffsetPaginationRequest>.State(
            items: items,
            position: .zero
        )) {
            PaginatorReducer<TestItem, PaginatorAction, Int, OffsetPaginationRequest>(
                requestBuilder: OffsetRequestBuilderStrategy(limit: .limit),
                positionBuilder: OffsetPositionBuilderStrategy()
            )
        }

        await store.send(.itemAppeared(items[0].id))
    }

    func test_thatPaginatorCursorRequestsNextPage_whenLastItemDidAppear() async throws {
        let items: IdentifiedArray<UUID, TestItem> = .items(count: .limit)
        let id = try XCTUnwrap(items.last?.id)

        let store = TestStore(
            initialState: PaginatorReducer<TestItem, PaginatorAction, UUID, CursorPaginationRequest<TestItem>>.State(
                items: items, position: id
            )
        ) {
            PaginatorReducer<TestItem, PaginatorAction, UUID, CursorPaginationRequest<TestItem>>(
                requestBuilder: CursorRequestBuilderStrategy(),
                positionBuilder: CursorPositionBuilderStrategy()
            )
        }

        await store.send(.itemAppeared(items[.limit - 1].id)) {
            $0.isLoading = true
        }

        await store.receive(.requestPage(CursorPaginationRequest(id: id)))
    }

    func test_thatPaginatorCursorDoesNotRequestNextPage_whenLastItemDidNotAppear() async {
        let items: IdentifiedArray<UUID, TestItem> = .items(count: .limit)

        let store = TestStore(
            initialState: PaginatorReducer<TestItem, PaginatorAction, UUID, CursorPaginationRequest<TestItem>>.State(
                items: items,
                position: items[0].id
            )
        ) {
            PaginatorReducer<TestItem, PaginatorAction, UUID, CursorPaginationRequest<TestItem>>(
                requestBuilder: CursorRequestBuilderStrategy(),
                positionBuilder: CursorPositionBuilderStrategy()
            )
        }

        await store.send(.itemAppeared(items[0].id))
    }
}

// MARK: - Constants

private extension Int {
    static let limit = 10
}

/// https://engineering.monstar-lab.com/en/post/2023/10/26/The-Composable-architecture-and-TDD/
