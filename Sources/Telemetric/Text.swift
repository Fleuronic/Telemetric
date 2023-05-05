// Copyright © Fleuronic LLC. All rights reserved.

import UIKit
import ReactiveKit
import Bond

import struct Metric.Styled
import protocol Metric.Text

public extension Styled where Base: Text {
	func textColorAssetFromSource<Source: SignalProtocol, TextColor>(_ source: Source) -> Self where Source.Element == (TextColor.Type) -> UIColor, Source.Error == Never {
		_ = source.map { $0(TextColor.self) }.bind(to: base.reactive.textColor)
		return self
	}
}

// MARK: -
private extension ReactiveExtensions where Base: Text {
	var textColor: Bond<UIColor> {
		bond { $0.setTextColor($1) }
	}
}
