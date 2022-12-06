// Copyright © Fleuronic LLC. All rights reserved.

import enum Metric.Border
import class UIKit.UIView
import struct Metric.Opacity
import struct Bond.Bond
import protocol Layoutless.AnyLayout
import protocol ReactiveKit.ReactiveExtensions

public final class View: UIView {}

// MARK: -
extension View: Stylable {}

// MARK: -
public extension UIView {
	static var container: Styled<View> {
		.init()
	}
}

// MARK: -
public extension Styled<View> {
	func addingLayout(_ layout: AnyLayout) -> AnyLayout {
		value.addingLayout(layout)
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
