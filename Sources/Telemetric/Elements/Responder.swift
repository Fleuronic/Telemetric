// Copyright © Fleuronic LLC. All rights reserved.

import UIKit
import ReactiveSwift

public extension Reactive where Base: UIResponder {
	var isFocused: BindingTarget<Bool> {
		makeBindingTarget {
			_ = $1 ? $0.becomeFirstResponder() : $0.resignFirstResponder()
		}
	}
}
