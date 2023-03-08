// Copyright © Fleuronic LLC. All rights reserved.

import struct UIKit.CGFloat
import struct UIKit.CGRect
import struct UIKit.UIEdgeInsets
import struct Metric.Insets
import struct Metric.Kerning
import struct Bond.Bond
import struct ReactiveKit.SafeSignal
import class UIKit.UITextField
import class Foundation.NSCoder
import struct Foundation.NSRange
import protocol UIKit.UITextFieldDelegate
import protocol ReactiveKit.SignalProtocol
import protocol ReactiveKit.ReactiveExtensions

open class TextField: UITextField {
	open var rectInsets: UIEdgeInsets {
		.init(
			horizontal: horizontalInsets,
			vertical: verticalInsets
		)
	}

	public var maxLength: Int?
	public var acceptedCharacter: Regex<Substring>?
	public var horizontalInsets: Insets.Horizontal = .zero
	public var verticalInsets: Insets.Vertical = .zero
	private var insets: UIEdgeInsets = .zero

	public var kerning: Kerning? {
		get {
			(defaultTextAttributes[.kern] as? CGFloat).map(Kerning.init)
		}
		set {
			if let newValue {
				defaultTextAttributes.updateValue(newValue.value, forKey: .kern)
			} else {
				defaultTextAttributes.removeValue(forKey: .kern)
			}
		}
	}

	// MARK: NSCoding
	public required init(coder: NSCoder) {
		fatalError()
	}

	// MARK: UIView
	public override init(frame: CGRect) {
		super.init(frame: frame)
		self.delegate = self
	}

	// MARK: UITextField
	open override func textRect(forBounds bounds: CGRect) -> CGRect {
		super.textRect(forBounds: bounds).inset(by: rectInsets)
	}

	open override func editingRect(forBounds bounds: CGRect) -> CGRect {
		super.editingRect(forBounds: bounds).inset(by: rectInsets)
	}

	open override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
		super.placeholderRect(forBounds: bounds).inset(by: rectInsets)
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
		self.placeholder(source.map { $0(Strings.self) })
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
