// Copyright © Fleuronic LLC. All rights reserved.

import enum Metric.Spacing
import struct Metric.Insets
import class UIKit.UIStackView
import struct Layoutless.Layout
import protocol Layoutless.AnyLayout

// MARK: -
public extension Styled where Value: UIStackView {
	func content(_ content: [AnyLayout]) -> Layout<UIStackView> {
		.init { revertable in
			content.forEach { revertable.append($0.layout(in: value)) }
			return value
		}
	}

	func horizontalSpacing(_ spacing: Spacing.Horizontal) -> Self {
		value.spacing = spacing.value
		return self
	}

	func verticalSpacing(_ spacing: Spacing.Vertical) -> Self {
		value.spacing = spacing.value
		return self
	}

	func horizontalInsets(_ insets: Insets.Horizontal) -> Self {
		value.isLayoutMarginsRelativeArrangement = true
		value.directionalLayoutMargins.leading = insets.value
		value.directionalLayoutMargins.trailing = insets.value
		return self
	}

	func verticalInsets(_ insets: Insets.Vertical) -> Self {
		value.isLayoutMarginsRelativeArrangement = true
		value.directionalLayoutMargins.top = insets.value
		value.directionalLayoutMargins.bottom = insets.value
		return self
	}
}
