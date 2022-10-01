// Copyright © Fleuronic LLC. All rights reserved.

import enum Metric.Border
import class UIKit.UIView
import struct Metric.Opacity
import struct Bond.Bond
import protocol Layoutless.AnyLayout
import protocol ReactiveKit.ReactiveExtensions

public extension UIView {
	static var container: Styled<UIView> {
		.init(.init())
	}
}

// MARK: -
public extension Styled where Value: UIView {
	func addingLayout(_ layout: AnyLayout) -> AnyLayout {
		value.addingLayout(layout)
	}

	func borderWidth<BorderWidth>(_ width: (BorderWidth.Type) -> Border.Width) -> Self {
		value.borderWidth = width(BorderWidth.self)
		return self
	}
}

// MARK: -
public extension ReactiveExtensions where Base: UIView {
	var isVisible: Bond<Bool> {
		bond { $0.isHidden = !$1 }
	}

	var opacity: Bond<Opacity> {
		bond { $0.opacity = $1 }
	}
}
