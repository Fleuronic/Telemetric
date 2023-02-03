// Copyright © Fleuronic LLC. All rights reserved.

import class UIKit.UILabel
import protocol ReactiveKit.SignalProtocol

public final class Label: UILabel {}

// MARK: -
extension Label: TextStylable {}

// MARK: -
public extension Styled<Label> {
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
