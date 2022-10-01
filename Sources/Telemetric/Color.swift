// Copyright © Fleuronic LLC. All rights reserved.

import struct UIKit.CGFloat
import struct Metric.Percentage
import struct Metric.Opacity

import DynamicColor

import class UIKit.UIColor
import class UIKit.UIView
import class UIKit.UIButton

// MARK: -
public extension Styled where Value: UIView {
	func backgroundColorAsset<BackgroundColor>(_ color: (BackgroundColor.Type) -> UIColor) -> Self {
		value.backgroundColor = color(BackgroundColor.self)
		return self
	}

	func borderColorAsset<BorderColor>(_ color: (BorderColor.Type) -> UIColor) -> Self {
		value.layer.borderColor = color(BorderColor.self).cgColor
		return self
	}
}

// MARK: -
public extension Styled where Value: UIButton {
	func titleColorAsset<TextColor>(_ color: @escaping (TextColor.Type) -> UIColor) -> Self {
		let color = color(TextColor.self)
		value.setTitleColor(color, for: .normal)
		value.setTitleColor(color, for: .highlighted)
		value.setTitleColor(color, for: .disabled)
		return self
	}

	func backgroundColorAsset<BackgroundColor>(
		darkenedBy percentage: Percentage,
		fadedTo opacity: Opacity,
		color: @escaping (BackgroundColor.Type) -> UIColor
	) -> Self {
		value.configuration = .filled()
		value.configuration?.background.cornerRadius = .zero
		value.configuration?.activityIndicatorColorTransformer = .init { _ in value.titleColor(for: .normal)! }

		value.configurationUpdateHandler = {
			var color = color(BackgroundColor.self)

			switch $0.state {
			case .highlighted:
				color = color.darkened(amount: percentage.value)
			case .disabled:
				color = color.withAlphaComponent(opacity.value)
			default:
				break
			}

			$0.configuration?.background.backgroundColor = color
		}

		return self
	}
}
