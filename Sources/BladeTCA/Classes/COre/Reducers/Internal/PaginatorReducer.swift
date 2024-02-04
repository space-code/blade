//
// Blade
// Copyright © 2024 Space Code. All rights reserved.
//

import Blade
import ComposableArchitecture

struct PaginatorReducer<
    State: Equatable & Identifiable,
    Action: Equatable,
    PositionType: Equatable,
    Request: Equatable
>: Reducer {
    // MARK: Types

    typealias State = PaginatorState<State, PositionType>
    typealias Action = PaginatorAction<State, Action, Request>

    // MARK: Properties

    private let requestBuilder: any IRequestBuilderStrategy<Self.State, Request>
    private let positionBuilder: any IPositionBuilderStrategy<Self.State, PositionType>

    // MARK: Initialization

    init(
        requestBuilder: any IRequestBuilderStrategy<Self.State, Request>,
        positionBuilder: any IPositionBuilderStrategy<Self.State, PositionType>
    ) {
        self.requestBuilder = requestBuilder
        self.positionBuilder = positionBuilder
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

                state.position = positionBuilder.next(state: state)

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

        let request: Request = requestBuilder.makeRequest(state: state)
        return .send(.requestPage(request))
    }
}
