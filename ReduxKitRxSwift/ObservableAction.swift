//
//  ObservableAction.swift
//  ReduxKitRxSwift
//
//  Created by Karl Bowden on 23/12/2015.
//  Copyright © 2015 Redux. All rights reserved.
//

import ReduxKit
import RxSwift

public protocol ObservableAction: Action {
    var rawPayload: Observable<Action> { get set }
    func replacePayload(payload: Observable<Action>) -> ObservableAction
    // TODO: Refactor mutating functions back to ReduxKit.Action as protocols
}

public extension ObservableAction {
    /// Default implementation of the standard action payload and type
    public var payload: Any? { return rawPayload }
}

public protocol ObservableActionError: SimpleStandardAction, ErrorType {
}

public extension ObservableActionError {
    public var error: Bool { return true }
}
