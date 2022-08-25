// Copyright © Fleuronic LLC. All rights reserved.

import UIKit
import ReactiveKit
import Bond
import Metric

public extension UIView {
	func opacity<Source: SignalProtocol>(_ source: Source) -> Self where Source.Element == Opacity, Source.Error == Never {
		_ = source.bind(to: reactive.opacity)
		return self
	}
}

// MARK: -
private extension ReactiveExtensions where Base: UIView {
	var opacity: Bond<Opacity> {
		bond { $0.opacity = $1 }
	}
}
