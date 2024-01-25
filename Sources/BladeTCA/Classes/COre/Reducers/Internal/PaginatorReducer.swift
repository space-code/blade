//
// Blade
// Copyright © 2024 Space Code. All rights reserved.
//

import Blade
import ComposableArchitecture

struct PaginatorReducer<State: Equatable & Identifiable, Action: Equatable>: Reducer {
    // MARK: Types

    typealias State = PaginatorState<State>
    typealias Action = PaginatorAction<State, Action>

    // MARK: Properties

    private let limit: Int

    // MARK: Initialization

    init(limit: Int) {
        self.limit = limit
    }

    // MARK: Reducer

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .itemAppeared(id):
                guard state.items.last?.id == id else { return .none }
                return fetchNextPage(&state)
            case .requestPage:
                state.isLoading = true
                return fetchNextPage(&state)
            case let .response(.success(page)):
                state.isLoading = false

                state.items.append(contentsOf: page.items)
                state.hasMoreData = page.hasMoreData
                state.offset = page.offset

                return .none
            case .response(.failure):
                state.isLoading = false
                return .none
            }
        }
    }

    // MARK: Private

    private func fetchNextPage(_ state: inout Self.State) -> Effect<Self.Action> {
        guard !state.isLoading, state.hasMoreData else { return .none }
        state.isLoading = true

        return .send(.requestPage(LimitPageRequest(limit: limit, offset: state.offset)))
    }
}
