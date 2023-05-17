// Copyright © Fleuronic LLC. All rights reserved.

import UIKit
import ReactiveSwift
import ReactiveCocoa

import struct Geometric.Styled

public extension Styled where Base: UITextView {
	func edited(_ target: BindingTarget<String>) -> Base {
		target <~ base.reactive.continuousTextValues.skipRepeats()
		return base
	}
}
