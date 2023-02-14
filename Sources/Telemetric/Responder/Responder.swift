// Copyright © Fleuronic LLC. All rights reserved.

import class UIKit.UIResponder
import struct Bond.Bond
import protocol ReactiveKit.SignalProtocol
import protocol ReactiveKit.ReactiveExtensions

public extension ReactiveExtensions where Base: UIResponder {
	var isFocused: Bond<Bool> {
		bond { _ = $1 ? $0.becomeFirstResponder() : $0.resignFirstResponder()  }
	}
}
