// Copyright © Fleuronic LLC. All rights reserved.

import class Foundation.NSObject
import struct ReactiveKit.Reactive
import struct ReactiveKit.SafeSignal
import struct Bond.Bond
import struct Bond.DynamicSubject
import protocol ReactiveKit.SignalProtocol
import protocol ReactiveKit.ReactiveExtensionsProvider
import protocol ReactiveKit.BindableProtocol

@dynamicMemberLookup
public struct Styled<Value: NSObject & ReactiveExtensionsProvider> {
	let value: Value

	public init() {
		value = .init()
	}
}

// MARK: -
public extension Styled {
	subscript<T>(dynamicMember keyPath: WritableKeyPath<Value, T>) -> (T) -> Styled<Value> {
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
