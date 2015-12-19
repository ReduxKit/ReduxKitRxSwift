//
//  ReduxRxTests.swift
//  ReduxRxTests
//
//  Created by Karl Bowden on 20/12/2015.
//  Copyright © 2015 SwiftRedux. All rights reserved.
//

import XCTest
import RxSwift
import Redux
@testable import ReduxRx

class ReduxRxTests: XCTestCase {

    let store: Store<State> = ReduxRx.createStore(reducer)
    let action = IncrementAction()
    let action2 = IncrementAction(payload: 2)

    func testStoreCreation() {
        // Assert
        XCTAssert(store.state.count == 0)
    }

    func testStoreActions() {
        // Act
        store.dispatch(action)

        // Assert
        XCTAssert(store.state.count == 1)
    }

    func testStoreSubscription() {
        // Arrange
        var state: State!
        store.subscribe { state = $0 }

        // Act
        store.dispatch(action)

        // Assert
        XCTAssert(state.count == 1)
    }

    func testSubscribeInvokesCallbackImmediately() {
        // Act
        var state: State!
        store.subscribe { state = $0 }

        // Assert
        XCTAssert(state.count == 0)
    }

    func testMultipleActions() {
        // Arrange
        var state: State!
        store.subscribe { state = $0 }

        // Act
        store.dispatch(action)
        store.dispatch(action2)

        // Assert
        XCTAssert(state.count == 3)
    }

    func testDisposability() {
        // Arrange
        var state: State!
        var disposedState: State!
        store.subscribe { state = $0 }
        let disposable = store.subscribe { disposedState = $0 }

        // Act
        store.dispatch(action)
        disposable.dispose()
        store.dispatch(action)

        // Assert
        XCTAssert(state.count == 2)
        XCTAssert(disposedState.count == 1)
    }

    func testPerformance() {
        let count = 100000
        self.measureBlock {
            // Arrange
            let store = ReduxRx.createStore(reducer)
            let action = IncrementAction()
            var state: State!
            store.subscribe { state = $0 }

            // Act
            for _ in 1...count {
                store.dispatch(action)
            }

            // Assert
            XCTAssert(state.count == count)
        }
    }
}
