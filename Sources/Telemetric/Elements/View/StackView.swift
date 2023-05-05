// Copyright © Fleuronic LLC. All rights reserved.

import UIKit
import Layoutless

import struct Metric.Styled

public extension Styled where Base: UIStackView {
	func content(_ content: [AnyLayout]) -> Layout<UIStackView> {
		.init { revertable in
			content.forEach { revertable.append($0.layout(in: base)) }
			return base
		}
	}
}
