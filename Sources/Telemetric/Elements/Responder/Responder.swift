// Copyright © Fleuronic LLC. All rights reserved.

import UIKit
import ReactiveKit
import Bond

public extension ReactiveExtensions where Base: UIResponder {
	var isFocused: Bond<Bool> {
		bond { _ = $1 ? $0.becomeFirstResponder() : $0.resignFirstResponder()  }
	}
}
