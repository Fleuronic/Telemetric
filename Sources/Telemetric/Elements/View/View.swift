// Copyright © Fleuronic LLC. All rights reserved.

import enum Metric.Border
import enum Metric.Corner
import class UIKit.UIColor
import class UIKit.UIView
import struct Metric.Opacity
import struct Bond.Bond
import struct Layoutless.Layout
import protocol Layoutless.AnyLayout
import protocol ReactiveKit.ReactiveExtensions

extension UIView: Stylable {}

// MARK: -
public extension UIView {
	static var container: Styled<UIView> {
		.init()
	}
}

// MARK: -
public extension Styled where Value: UIView {
	var layout: Layout<UIView> {
		.just(value)
	}

	func addingLayout(_ layout: AnyLayout) -> AnyLayout {
		value.addingLayout(layout)
	}

	func borderWidth(width: (Border.Width.Type) -> Border.Width) -> Self {
		value.layer.borderWidth = width(Border.Width.self).value
		return self
	}

	func cornerRadius(radius: (Corner.Radius.Type) -> Corner.Radius) -> Self {
		value.layer.cornerRadius = radius(Corner.Radius.self).value
		return self
	}

	func backgroundColorAsset<BackgroundColor>(color: (BackgroundColor.Type) -> UIColor) -> Self {
		value.backgroundColor = color(BackgroundColor.self)
		return self
	}

	func borderColorAsset<BorderColor>(color: (BorderColor.Type) -> UIColor) -> Self {
		value.layer.borderColor = color(BorderColor.self).cgColor
		return self
	}
}

// MARK: -
public extension ReactiveExtensions where Base: UIView {
	var isVisible: Bond<Bool> {
		bond { $0.isHidden = !$1 }
	}

	var opacity: Bond<Opacity> {
		bond { $0.alpha = $1.value }
	}
}
