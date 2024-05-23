// Copyright © Fleuronic LLC. All rights reserved.

import ReactiveSwift

import struct Geometric.Styled

public extension Styled {
	subscript<Value>(dynamicMember keyPath: KeyPath<Reactive<Base>, BindingTarget<Value>>) -> (Property<Value>) -> Styled<Base> {
		{
			base.reactive[keyPath: keyPath] <~ $0
			return self
		}
	}
    
	subscript<Value>(dynamicMember keyPath: KeyPath<Reactive<Base>, BindingTarget<Value>>) -> (Property<Value>) -> Base {
		{
			base.reactive[keyPath: keyPath] <~ $0
			return base
		}
	}
}
