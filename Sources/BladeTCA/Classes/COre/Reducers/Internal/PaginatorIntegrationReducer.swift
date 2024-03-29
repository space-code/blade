//
// Blade
// Copyright © 2024 Space Code. All rights reserved.
//

import Blade
import ComposableArchitecture

struct PaginatorIntegrationReducer<
    Parent: Reducer,
    State: Equatable & Identifiable,
    Action: Equatable,
    PositionType: Equatable,
    Request: Equatable
>: Reducer {
    // MARK: Properties

    let parent: Parent
    let childState: WritableKeyPath<Parent.State, PaginatorState<State, PositionType>>
    let childAction: AnyCasePath<Parent.Action, PaginatorAction<State, Action, Request>>
    let loadPage: @Sendable (Request, Parent.State) async throws -> Page<State>
    let requestBuilderStrategy: any IRequestBuilderStrategy<PaginatorState<State, PositionType>, Request>
    let positionBuilderStrategy: any IPositionBuilderStrategy<PaginatorState<State, PositionType>, PositionType>

    private enum CancelID { case requestPage }

    // MARK: Reducer

    var body: some Reducer<Parent.State, Parent.Action> {
        Scope(state: childState, action: childAction) {
            PaginatorReducer(
                requestBuilder: requestBuilderStrategy,
                positionBuilder: positionBuilderStrategy
            )
        }

        Reduce { state, action in
            guard let paginatorAction = childAction.extract(from: action),
                  case let .requestPage(pageRequest) = paginatorAction
            else {
                return parent.reduce(into: &state, action: action)
            }

            return .run { [state] send in
                await send(childAction.embed(.response(TaskResult { try await loadPage(pageRequest, state) })))
            }
            .cancellable(id: CancelID.requestPage, cancelInFlight: true)
        }
    }
}
