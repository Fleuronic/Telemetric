// Copyright © Fleuronic LLC. All rights reserved.

import ReactiveKit
import Bond

@dynamicMemberLookup
public struct Styled<Value: Stylable> {
	var value: Value

	public init() {
		value = .init()
	}
}

// MARK: -
public extension Styled {
	subscript<T>(dynamicMember keyPath: WritableKeyPath<Value, T>) -> (T) -> Self {
		{
			var value = self.value
			value[keyPath: keyPath] = $0
			return .init(value: value)
		}
	}

	subscript<Source: SignalProtocol>(dynamicMember keyPath: KeyPath<Reactive<Value>, Bond<Source.Element>>) -> (Source) -> Styled<Value> where Source.Error == Never {
		{
			_ = $0.bind(to: value.reactive[keyPath: keyPath])
			return self
		}
	}

	subscript<Source: SignalProtocol>(dynamicMember keyPath: KeyPath<Reactive<Value>, DynamicSubject<Source.Element?>>) -> (Source) -> Styled<Value> where Source.Error == Never {
		{
			_ = $0.bind(to: value.reactive[keyPath: keyPath])
			return self
		}
	}

	subscript<Target: BindableProtocol>(dynamicMember keyPath: KeyPath<Reactive<Value>, SafeSignal<Target.Element>>) -> (Target) -> Value {
		{
			_ = $0.bind(signal: value.reactive[keyPath: keyPath])
			return value
		}
	}
}

// MARK: -
private extension Styled {
	init(value: Value) {
		self.value = value
	}
}
