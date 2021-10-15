import SwiftUI
import Combine

public extension Binding {
  @discardableResult
  func onSet(_ body: @escaping (Value) -> ()) -> Self {
    return .init(
      get: { self.wrappedValue },
      set: { self.wrappedValue = $0; body($0) }
    )
  }

  @discardableResult
  func onChange(perform action: @escaping (Value) -> ()) -> Self where Value: Equatable {
    return .init(
      get: { self.wrappedValue },
      set: { newValue in
        let oldValue = self.wrappedValue
        self.wrappedValue = newValue
        if newValue != oldValue  {
          action(newValue)
        }
      }
    )
  }

  func asAnyPublisher() -> AnyPublisher<Value, Never> where Value: Equatable {
    let passthroughSubject = PassthroughSubject<Value, Never>()
    onChange { value in
      passthroughSubject.send(value)
    }
    return passthroughSubject.eraseToAnyPublisher()
  }
}
