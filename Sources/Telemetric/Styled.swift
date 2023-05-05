// Copyright © Fleuronic LLC. All rights reserved.

import ReactiveKit
import Bond

import struct Metric.Styled

public extension Styled {
	subscript<Source: SignalProtocol>(dynamicMember keyPath: KeyPath<Reactive<Base>, Bond<Source.Element>>) -> (Source) -> Styled<Base> where Source.Error == Never {
		{
			_ = $0.bind(to: base.reactive[keyPath: keyPath])
			return self
		}
	}

	subscript<Source: SignalProtocol>(dynamicMember keyPath: KeyPath<Reactive<Base>, DynamicSubject<Source.Element?>>) -> (Source) -> Styled<Base> where Source.Error == Never {
		{
			_ = $0.bind(to: base.reactive[keyPath: keyPath])
			return self
		}
	}

	subscript<Target: BindableProtocol>(dynamicMember keyPath: KeyPath<Reactive<Base>, SafeSignal<Target.Element>>) -> (Target) -> Base {
		{
			_ = $0.bind(signal: base.reactive[keyPath: keyPath])
			return base
		}
	}
}
