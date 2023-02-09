// Copyright © Fleuronic LLC. All rights reserved.

import struct UIKit.CGRect
import struct Bond.Bond
import struct ReactiveKit.SafeSignal
import class UIKit.UITextField
import class Foundation.NSCoder
import struct Foundation.NSRange
import protocol UIKit.UITextFieldDelegate
import protocol ReactiveKit.SignalProtocol
import protocol ReactiveKit.ReactiveExtensions

open class TextField: UITextField {
	public var maxLength: Int?
	public var acceptedCharacter: Regex<Substring>?

	// MARK: NSCoding
	public required init(coder: NSCoder) {
		fatalError()
	}

	// MARK: UIView
	public override init(frame: CGRect) {
		super.init(frame: frame)
		self.delegate = self
	}
}

// MARK: -
extension TextField: UITextFieldDelegate {
	public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		guard
			!string.isEmpty,
			let text = textField.text,
			let range = Range(range, in: text) else { return true }

		let result = text.replacingCharacters(in: range, with: string)
		return
			maxLength.map { result.count <= $0 } ?? true &&
			acceptedCharacter.map(string.wholeMatch).map { $0 != nil } ?? true
	}
}

extension TextField: TextStylable {}

// MARK: -
public extension Styled<TextField> {
	func placeholder<Source: SignalProtocol, Strings>(_ source: Source) -> Self where Source.Element == (Strings.Type) -> String, Source.Error == Never {
		_ = source.map { $0(Strings.self) }.bind(to: value.reactive.placeholder)
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
