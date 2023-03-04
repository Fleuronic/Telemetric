// Copyright © Fleuronic LLC. All rights reserved.

import class UIKit.UILabel
import protocol ReactiveKit.SignalProtocol

extension UILabel: TextStylable {}

// MARK: -
public extension Styled<UILabel> {
	var multiline: Self {
		self.numberOfLines(0)
	}

	func text<Source: SignalProtocol, Strings>(_ source: Source) -> UILabel where Source.Element == (Strings.Type) -> String, Source.Error == Never {
		_ = source.map { $0(Strings.self) }.bind(to: value.reactive.text)
		return value
	}
}
