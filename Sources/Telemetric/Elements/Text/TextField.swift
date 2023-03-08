// Copyright © Fleuronic LLC. All rights reserved.

import struct UIKit.CGFloat
import struct UIKit.CGRect
import struct UIKit.UIEdgeInsets
import struct Metric.Insets
import struct Metric.Kerning
import struct ReactiveKit.SafeSignal
import struct Bond.Bond
import class UIKit.UITextField
import class Foundation.NSCoder
import struct Foundation.NSRange
import protocol UIKit.UITextFieldDelegate
import protocol ReactiveKit.SignalProtocol
import protocol ReactiveKit.ReactiveExtensions

open class TextField: UITextField {
	open var rectInsets: UIEdgeInsets { insets }

	public var maxLength: Int?
	public var acceptedCharacter: Regex<Substring>?

	fileprivate var insets: UIEdgeInsets = .zero

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
public extension Styled where Value: UITextField {
	func kerning(named name: Kerning.Name) -> Self {
		value.defaultTextAttributes.updateValue(name(Kerning.self).value, forKey: .kern)
		return self
	}

	func placeholder<Source: SignalProtocol, Strings>(_ source: Source) -> Self where Source.Element == (Strings.Type) -> String, Source.Error == Never {
		self.placeholder(source.map { $0(Strings.self) })
	}
}

// MARK: -
public extension Styled where Value: TextField {
	func horizontalInsets(named name: Insets.Horizontal.Name) -> Self {
		let inset = name(Insets.Horizontal.self).value
		value.insets.left = inset
		value.insets.right = inset
		return self
	}

	func verticalInsets(named name: Insets.Vertical.Name) -> Self {
		let inset = name(Insets.Vertical.self).value
		value.insets.top = inset
		value.insets.bottom = inset
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
