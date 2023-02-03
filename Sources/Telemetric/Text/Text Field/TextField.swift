// Copyright © Fleuronic LLC. All rights reserved.

import struct UIKit.CGRect
import struct Bond.Bond
import struct ReactiveKit.SafeSignal
import class UIKit.UIView
import class UIKit.UITextField
import class UIKit.UITextPosition
import class Foundation.NSCoder
import struct Foundation.NSRange
import protocol UIKit.UITextFieldDelegate
import protocol ReactiveKit.SignalProtocol
import protocol ReactiveKit.ReactiveExtensions

public final class TextField: UITextField {
	public var maxLength: Int?
	public var acceptedCharacter: Regex<Substring>?

	public var showsCursor = true {
		didSet {
			if showsCursor {
				coverView.removeFromSuperview()
			} else {
				addSubview(coverView)
			}
		}
	}

	private lazy var coverView: UIView = {
		let view = UIView()
		addSubview(view)
		return view
	}()

	// MARK: NSCoding
	required init(coder: NSCoder) {
		fatalError()
	}

	// MARK: UIView
	public override init(frame: CGRect) {
		super.init(frame: frame)
		self.delegate = self
	}

	public override func layoutSubviews() {
		super.layoutSubviews()

		if !showsCursor {
			coverView.frame = bounds
			bringSubviewToFront(coverView)
		}
	}

	// MARK: UITextInput
	public override func caretRect(for position: UITextPosition) -> CGRect {
		showsCursor ? super.caretRect(for: position) : .zero
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
