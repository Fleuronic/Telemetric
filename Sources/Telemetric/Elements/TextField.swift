// Copyright © Fleuronic LLC. All rights reserved.

import UIKit
import ReactiveSwift

import struct Metric.Styled
import protocol Metric.Text

public extension Styled where Base: UITextField {
	func edited(_ target: BindingTarget<String>) -> Base {
		target <~ base.reactive.continuousTextValues.skipRepeats()
		return base
	}

	func placeholder<Strings>(_ property: Property<(Strings.Type) -> String>) -> Self {
		base.reactive.placeholder <~ property.map { $0(Strings.self) }
		return self
	}
}
