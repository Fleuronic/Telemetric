// Copyright © Fleuronic LLC. All rights reserved.

import struct Bond.Bond
import class UIKit.UIButton
import protocol ReactiveKit.SignalProtocol
import protocol ReactiveKit.ReactiveExtensions

public final class Button: UIButton {}

// MARK: -
extension Button: Stylable {}

// MARK: -
public extension Styled<Button> {
	func title<Source: SignalProtocol, Strings>(_ source: Source) -> Self where Source.Element == (Strings.Type) -> String, Source.Error == Never {
		_ = source.map { $0(Strings.self) }.bind(to: value.reactive.title)
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
