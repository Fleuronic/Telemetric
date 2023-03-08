// Copyright © Fleuronic LLC. All rights reserved.

import DynamicColor
import enum Metric.Corner
import struct Metric.Percentage
import struct Metric.Opacity
import struct Bond.Bond
import class UIKit.UIColor
import class UIKit.UIButton
import protocol ReactiveKit.SignalProtocol
import protocol ReactiveKit.ReactiveExtensions

// MARK: -
public extension Styled where Value: UIButton {
	func title<Source: SignalProtocol, Strings>(_ source: Source) -> Self where Source.Element == (Strings.Type) -> String, Source.Error == Never {
		_ = source.map { $0(Strings.self) }.bind(to: value.reactive.title)
		return self
	}

	func cornerRadius(radius: (Corner.Radius.Type) -> Corner.Radius) -> Self {
		value.configuration?.background.cornerRadius = radius(Corner.Radius.self).value
		return self
	}

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


// MARK: -
public extension ReactiveExtensions where Base: UIButton {
	var showsActivity: Bond<Bool> {
		bond {
			$0.setTitle($1 ? .init() : $0.currentTitle, for: .normal)
			$0.configuration?.showsActivityIndicator = $1
		}
	}
}
