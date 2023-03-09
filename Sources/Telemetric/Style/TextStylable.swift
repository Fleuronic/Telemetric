// Copyright © Fleuronic LLC. All rights reserved.

import UIKit
import ReactiveKit
import Bond

public protocol TextStylable: Stylable {
	var textAlignment: NSTextAlignment { get set }
}

// MARK: -
public extension Styled where Value: TextStylable {
	var centered: Self {
		self.textAlignment(.center)
	}

	func textColorAsset<TextColor>(_ textColor: @escaping (TextColor.Type) -> UIColor) -> Self {
		let color = textColor(TextColor.self)
		value.setTextColor(color)
		return self
	}

	func textColorAssetFromSource<Source: SignalProtocol, TextColor>(_ source: Source) -> Self where Source.Element == (TextColor.Type) -> UIColor, Source.Error == Never {
		_ = source.map { $0(TextColor.self) }.bind(to: value.reactive.textColor)
		return self
	}
}

// MARK: -
private extension TextStylable {
	func setTextColor(_ color: UIColor) {
		(self as? UILabel)?.textColor = color
		(self as? UITextField)?.textColor = color
		(self as? UITextView)?.textColor = color
	}
}

// MARK: -
private extension ReactiveExtensions where Base: TextStylable {
	var textColor: Bond<UIColor> {
		bond { $0.setTextColor($1) }
	}
}
