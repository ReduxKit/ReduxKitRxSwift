//
//  Mocks.swift
//  ReduxKitRxSwift
//
//  Created by Karl Bowden on 20/12/2015.
//  Copyright © 2015 ReduxKit. All rights reserved.
//

import ReduxKit

struct State {
    let count: Int
}

struct IncrementAction: StandardAction {
    let meta: Any?
    let error: Bool
    let rawPayload: Int

    init(payload: Int? = nil, meta: Any? = nil, error: Bool = false) {
        self.rawPayload = payload ?? 1
        self.meta = meta
        self.error = error
    }
}

func reducer(state: State? = nil, action: Action) -> State {
    let count = state?.count ?? 0

    switch action {
    case let action as IncrementAction:
        return State(count: count + action.rawPayload)
    default:
        return State(count: count)
    }
}
