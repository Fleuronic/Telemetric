// Copyright © Fleuronic LLC. All rights reserved.

import ReactiveSwift

import struct Geometric.Styled

public extension Styled {
	subscript<T>(dynamicMember keyPath: KeyPath<Reactive<Base>, BindingTarget<T>>) -> (Property<T>) -> Styled<Base> {
		{
			base.reactive[keyPath: keyPath] <~ $0
			return self
		}
	}
}
