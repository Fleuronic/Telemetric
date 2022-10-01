// Copyright © Fleuronic LLC. All rights reserved.

import class UIKit.UIColor
import class UIKit.UILabel
import class UIKit.UITextField
import class UIKit.UITextView
import struct ReactiveKit.SafeSignal
import struct Bond.Bond
import protocol Metric.TextStyled
import protocol ReactiveKit.SignalProtocol
import protocol ReactiveKit.ReactiveExtensions

public extension Styled where Value: UILabel {
	var multiline: Self {
		self.numberOfLines(0)
	}

	func text<Source: SignalProtocol, Strings>(_ source: Source) -> UILabel where Source.Element == (Strings.Type) -> String, Source.Error == Never {
		_ = source.map { $0(Strings.self) }.bind(to: value.reactive.text)
		return value
	}


	func text<Source: SignalProtocol>(_ source: Source) -> UILabel where Source.Element == String?, Source.Error == Never {
		_ = source.bind(to: value.reactive.text)
		return value
	}
}

// MARK: -
public extension Styled where Value: UITextField {
	func placeholder<Source: SignalProtocol, Strings>(_ source: Source) -> Self where Source.Element == (Strings.Type) -> String, Source.Error == Never {
		_ = source.map { $0(Strings.self) }.bind(to: value.reactive.placeholder)
		return self
	}
}

// MARK: -
public extension Styled where Value: TextStyled {
	var centered: Self {
		self.textAlignment(.center)
	}

	func textColorAsset<TextColor>(_ textColor: @escaping (TextColor.Type) -> UIColor) -> Self {
		let color = textColor(TextColor.self)
		(value as? UILabel)?.textColor = color
		(value as? UITextField)?.textColor = color
		(value as? UITextView)?.textColor = color
		return self
	}
}

// MARK: -
public extension ReactiveExtensions where Base: UITextField {
	var edited: SafeSignal<String> {
		text.ignoreNils().removeDuplicates()
	}
}

// MARK: -
private extension ReactiveExtensions where Base: UITextField {
	var placeholder: Bond<String> {
		bond { $0.placeholder = $1 }
	}
}

// MARK: -
public extension ReactiveExtensions where Base: UITextView {
	var edited: SafeSignal<String> {
		text.ignoreNils().removeDuplicates()
	}
}
