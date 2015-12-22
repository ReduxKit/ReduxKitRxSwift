# ReduxKitRxSwift

RxSwift bindings for ReduxKit.

```swift
import ReduxKitRxSwift
let store = createStore(reducer)
```

## Usage / Quick start

```swift
import RxSwift
import Redux
import ReduxKitRxSwift

// Setup State, Actions and Reducers
struct State {
    let count: Int
}

struct IncrementAction: SimpleStandardAction {
    let meta: Any? = nil
    let error: Bool = false
    let rawPayload: Any? = nil
}

func reducer(previousState: State? = nil, action: Action) -> State {
    let state = previousState ?? State(count: 0)

    switch action {
    case let action as IncrementAction:
        return State(count: state.count + 1)
    default:
        return state
    }
}

// Create the Store
let store: Store<State> = ReduxKitRxSwift.createStore(reducer)

let disposable = store.subscribe { print("Count: \($0.count)") }
// -> Count: 0

store.dispatch(IncrementAction())
// -> Count: 1

disposable.dispose()

store.dispatch(IncrementAction())
// ->
```

## Installation

### [Carthage](https://github.com/Carthage/Carthage)

Add ReduxKitRxSwift to `Cartfile`
```
github "ReduxKit/ReduxKit" ~> 0.1
github "ReduxKit/ReduxKitRxSwift" ~> 0.1
```

Run in terminal:
```bash
$ carthage update
```

### [CocoaPods](http://cocoapods.org)

Add ReduxKitRxSwift to your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'

pod 'ReduxKit', '~> 0.1'
pod 'ReduxKitRxSwift', '~> 0.1'
```

Then, run the following command:

```bash
$ pod install
```

## API

### createStore

```swift
func createStore<State>(reducer: Reducer, state: State? = nil)
	-> Store<State>
```

Uses `createStateStream` to create a `ReduxKit.Store<State>` using an `RxSwift.Variable<State>` stream.


### createStateStream

```swift
public func createStream<State>(state: State)
	-> StateStream<State>
```

Accepts a `State` and returns `ReduxKit.StateStream<State>` using an `RxSwift.Variable<State>` as the stream provider.

### createDisposable

```swift
func createDisposable(disposable: RxSwift.Disposable)
	-> ReduxDisposable
```

Accepts an `RxSwift.Disposable` and returns it wrapped as a `ReduxDisposable`.

The returned disposable only supports the `disposable.dispose()` function and does not return disposed state (`disposable.disposed` always returns `false`).
