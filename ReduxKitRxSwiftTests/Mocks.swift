//
//  Mocks.swift
//  ReduxKitRxSwift
//
//  Created by Karl Bowden on 20/12/2015.
//  Copyright © 2015 ReduxKit. All rights reserved.
//

import RxSwift
import ReduxKit
import ReduxKitRxSwift

// MARK: - State

struct State {
    let count: Int
    let sendStatus: String!
}

// MARK: - Actions

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


struct TestObservableAction: ObservableAction {
    typealias PayloadType = Int

    let meta: Any?
    let error: Bool
    var rawPayload: Observable<Action>

    init(success: Bool = true) {
        self.meta = nil
        self.error = !success
        self.rawPayload = TestObservableAction.Payload(success)
    }

    private init(meta: Any?, error: Bool, rawPayload: Observable<Action>) {
        self.meta = meta
        self.error = error
        self.rawPayload = rawPayload
    }

    func replacePayload(payload: Observable<Action>) -> ObservableAction {
        return self.dynamicType.init(meta: self.meta, error: self.error, rawPayload: payload)
    }

    static func Payload(success: Bool = true) -> Observable<Action> {
        return create { observer in

            if (success) {
                observer.on(.Next(TestObservableSuccessAction()))
            }
            else {
                observer.on(.Error(TestObservableErrorAction()))
            }

            observer.on(.Completed)

            return NopDisposable.instance
        }
    }
}

struct TestObservableSuccessAction: SimpleStandardAction{
    let meta: Any? = nil
    let error: Bool = false
    let rawPayload: String = "Success"
}

struct TestObservableErrorAction: ObservableActionError {
    let meta: Any? = nil
    let rawPayload: String = "Error"
}

enum TestObservableError: ErrorType{
    case ObservableFailed
}


// MARK: - Reducers

func reducer(state: State? = nil, action: Action) -> State {
    return State(
        count: countReducer(state?.count, action: action),
        sendStatus: observableReducer(state?.sendStatus, action: action)
    )
}

/// Add IncrementAction payload values to the previous value
func countReducer(previousState: Int? = nil, action: Action) -> Int {
    let state = previousState ?? 0

    switch action {
    case let action as IncrementAction:
        return state + action.rawPayload
    default:
        return state
    }
}


func observableReducer(previousState: String?, action: Action) -> String{
    var state = previousState ?? ""

    switch action{
    case let action as TestObservableSuccessAction:
        state = action.rawPayload
        return state
    case let action as TestObservableErrorAction:
        state = action.rawPayload
        return state
    default:
        return state
    }
}


// MARK: - Middleware

/// Logs dispatched actions to the console for debugging
func loggerMiddleware<State>(store: Store<State>) -> DispatchTransformer {
    return { next in
        { action in
            print(action.type)
            return next(action)
        }
    }
}
