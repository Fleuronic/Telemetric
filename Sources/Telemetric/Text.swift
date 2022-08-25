// Copyright © Fleuronic LLC. All rights reserved.

import UIKit
import ReactiveKit

public extension UILabel {
	static func text<Source: SignalProtocol, Strings>(_ source: Source) -> UILabel where Source.Element == (Strings.Type) -> String, Source.Error == Never {
		let label = UILabel()
		_ = source.map { $0(Strings.self) }.bind(to: label.reactive.text)
		return label
	}
}

// MARK: -
public extension UITextField {
	func edited<Target: BindableProtocol>(_ target: Target) -> Self where Target.Element == String {
		_ = target.bind(signal: reactive.editedText)
		return self
	}

	static func text<Source: SignalProtocol>(_ source: Source) -> UITextField where Source.Element == String, Source.Error == Never {
		let textField = UITextField()
		_ = source.bind(to: textField.reactive.text)
		return textField
	}
}


// MARK: -
public extension UITextView {
	func edited<Target: BindableProtocol>(_ target: Target) -> Self where Target.Element == String {
		_ = target.bind(signal: reactive.editedText)
		return self
	}

	static func text<Source: SignalProtocol>(_ source: Source) -> UITextView where Source.Element == String, Source.Error == Never {
		let textView = UITextView()
		_ = source.bind(to: textView.reactive.text)
		return textView
	}
}

// MARK: -
private extension ReactiveExtensions where Base: UITextField {
	var editedText: SafeSignal<String> {
		text.ignoreNils().removeDuplicates()
	}
}

// MARK: -
private extension ReactiveExtensions where Base: UITextView {
	var editedText: SafeSignal<String> {
		text.ignoreNils().removeDuplicates()
	}
}
