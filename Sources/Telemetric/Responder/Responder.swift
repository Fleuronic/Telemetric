// Copyright © Fleuronic LLC. All rights reserved.

import class UIKit.UIResponder
import struct Bond.Bond
import protocol ReactiveKit.SignalProtocol
import protocol ReactiveKit.ReactiveExtensions

public extension Styled where Value: UIResponder {
	func isFocused<Source: SignalProtocol>(_ source: Source) -> Self where Source.Element == Bool, Source.Error == Never {
		_ = source.bind(to: value.reactive.isFocused)
		return self
	}
}

// MARK: -
private extension ReactiveExtensions where Base: UIResponder {
	var isFocused: Bond<Bool> {
		bond { _ = $1 ? $0.becomeFirstResponder() : $0.resignFirstResponder()  }
	}
}
