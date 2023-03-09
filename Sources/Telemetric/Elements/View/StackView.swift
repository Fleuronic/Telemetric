// Copyright © Fleuronic LLC. All rights reserved.

import UIKit
import Layoutless
import enum Metric.Spacing
import struct Metric.Insets

public extension Styled where Value: UIStackView {
	func content(_ content: [AnyLayout]) -> Layout<UIStackView> {
		.init { revertable in
			content.forEach { revertable.append($0.layout(in: value)) }
			return value
		}
	}

	func horizontalSpacing(named name: Spacing.Horizontal.Name) -> Self {
		value.spacing = name(Spacing.Horizontal.self).value
		return self
	}

	func verticalSpacing(named name: Spacing.Vertical.Name) -> Self {
		value.spacing = name(Spacing.Vertical.self).value
		return self
	}

	func horizontalInsets(named name: Insets.Horizontal.Name) -> Self {
		let insets = name(Insets.Horizontal.self).value
		value.isLayoutMarginsRelativeArrangement = true
		value.directionalLayoutMargins.leading = insets
		value.directionalLayoutMargins.trailing = insets
		return self
	}

	func verticalInsets(named name: Insets.Vertical.Name) -> Self {
		let insets = name(Insets.Vertical.self).value
		value.isLayoutMarginsRelativeArrangement = true
		value.directionalLayoutMargins.top = insets
		value.directionalLayoutMargins.bottom = insets
		return self
	}
}
