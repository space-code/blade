//
// Blade
// Copyright © 2024 Space Code. All rights reserved.
//

import Blade
@testable import BladeTCA
import ComposableArchitecture
import XCTest

// MARK: - PaginatorIntegrationReducerTests

@MainActor
final class PaginatorIntegrationReducerTests: XCTestCase {
    // MARK: Tests

    func test_thatPaginatorUpdatesData_whenRequestDidCompleteSuccessfully() async {
        let items: IdentifiedArray<UUID, TestItem> = .items(count: .limit)
        let pageResponse = Page<TestItem>(items: items.elements, hasMoreData: true)

        let store = TestStore(
            initialState: PaginatorIntegrationReducer<TestReducer, TestItem, Never, Int, OffsetPaginationRequest>
                .State(paginator: .init(items: items, position: .limit))
        ) {
            PaginatorIntegrationReducer(
                parent: TestReducer(),
                childState: \TestReducer.State.paginator,
                childAction: /TestReducer.Action.child,
                loadPage: { _, _ in pageResponse },
                requestBuilderStrategy: OffsetRequestBuilderStrategy(limit: .limit),
                positionBuilderStrategy: OffsetPositionBuilderStrategy()
            )
        }

        // 1. Last item did appear
        await store.send(.child(.itemAppeared(items[items.count - 1].id))) {
            $0.paginator.isLoading = true
        }

        // 2. Send a request
        await store.receive(.child(.requestPage(OffsetPaginationRequest(limit: .limit, offset: .limit))))

        // 3. Receive a response
        await store.receive(.child(.response(.success(pageResponse)))) {
            $0.paginator.isLoading = false
            $0.paginator.hasMoreData = true
            $0.paginator.position = .limit
        }
    }

    func test_thatPaginatorDoesNotUpdateData_whenRequestDidFailed() async {
        let items: IdentifiedArray<UUID, TestItem> = .items(count: .limit)

        let store = TestStore(
            initialState: PaginatorIntegrationReducer<TestReducer, TestItem, Never, Int, OffsetPaginationRequest>
                .State(paginator: .init(items: items, position: .limit))
        ) {
            PaginatorIntegrationReducer(
                parent: TestReducer(),
                childState: \TestReducer.State.paginator,
                childAction: /TestReducer.Action.child,
                loadPage: { _, _ in throw URLError(.unknown) },
                requestBuilderStrategy: OffsetRequestBuilderStrategy(limit: .limit),
                positionBuilderStrategy: OffsetPositionBuilderStrategy()
            )
        }

        await store.send(.child(.itemAppeared(items[items.count - 1].id))) {
            $0.paginator.isLoading = true
        }

        await store.receive(.child(.requestPage(OffsetPaginationRequest(limit: .limit, offset: .limit))))
        await store.receive(.child(.response(.failure(URLError(.unknown))))) {
            $0.paginator.isLoading = false
            $0.paginator.hasMoreData = true
        }
    }
}

// MARK: PaginatorIntegrationReducerTests.TestReducer

private extension PaginatorIntegrationReducerTests {
    @Reducer
    struct TestReducer {
        struct State: Equatable {
            var paginator: PaginatorState<TestItem, Int>
        }

        enum Action: Equatable {
            case child(BladeTCA.PaginatorAction<TestItem, Never, OffsetPaginationRequest>)
        }

        var body: some ReducerOf<Self> {
            Reduce { _, action in
                switch action {
                case .child:
                    return .none
                }
            }
        }
    }
}

// MARK: - Constants

private extension Int {
    static let limit = 10
}
