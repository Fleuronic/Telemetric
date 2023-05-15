// Copyright © Fleuronic LLC. All rights reserved.

import UIKit
import ReactiveSwift
import ReactiveCocoa

import struct Metric.Styled
import protocol Metric.Text

public extension Styled where Base: Text {
	func textColorAsset<TextColor>(_ property: Property<(TextColor.Type) -> UIColor>) -> Self  {
		base.reactive.textColor <~ property.map { $0(TextColor.self) }
		return self
	}
}

// MARK: -
private extension Reactive where Base: Text {
	var textColor: BindingTarget<UIColor> {
		makeBindingTarget { $0.setTextColor($1) }
	}
}
