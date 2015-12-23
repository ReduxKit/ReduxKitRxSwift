//
//  ObservableMiddlewareTests.swift
//  ReduxKitRxSwift
//
//  Created by Karl Bowden on 23/12/2015.
//  Copyright © 2015 ReduxKit. All rights reserved.
//

import XCTest
import RxSwift
import ReduxKit
@testable import ReduxKitRxSwift

class ObservableMiddlewareTests: XCTestCase {

    var defaultState: State!
    var store: Store<State>!

    override func setUp() {
        super.setUp()

        store = applyMiddleware([
            loggerMiddleware,
            observableMiddleware
            ])(ReduxKitRxSwift.createStore)(reducer, nil)

        defaultState = store.getState()
    }

    /// it should succesfully dispatch successAction when the observable succeeds
    func testDispatchSuccessAction() {

        // Arrange
        let action = TestObservableAction()
        var state: State!
        store.subscribe { state = $0 }

        // Act
        let observableAction = store.dispatch(action) as! ObservableAction
        let preSubscribeState = state
        observableAction.rawPayload.subscribe().dispose()

        // Assert
        XCTAssert(preSubscribeState.sendStatus == "")
        XCTAssert(state.sendStatus == "Success")
    }

    /// it should succesfully dispatch an error when the observable fails
    func testDispatchErrorAction() {

        // Arrange
        let action = TestObservableAction(success: false)
        var state: State!
        store.subscribe { state = $0 }

        // Act
        let observableAction = store.dispatch(action) as! ObservableAction
        let preSubscribeState = state
        observableAction.rawPayload.subscribe().dispose()

        // Assert
        XCTAssert(preSubscribeState.sendStatus == "")
        XCTAssert(state.sendStatus == "Error")
    }
}
