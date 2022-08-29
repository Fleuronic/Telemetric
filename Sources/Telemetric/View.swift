// Copyright © Fleuronic LLC. All rights reserved.

import UIKit
import ReactiveKit
import Bond
import Metric

public extension UIView {
	func visible<Source: SignalProtocol>(_ source: Source) -> Self where Source.Element == Bool, Source.Error == Never {
		_ = source.bind(to: reactive.isVisible)
		return self
	}

	func hidden<Source: SignalProtocol>(_ source: Source) -> Self where Source.Element == Bool, Source.Error == Never {
		_ = source.bind(to: reactive.isHidden)
		return self
	}

	func opacity<Source: SignalProtocol>(_ source: Source) -> Self where Source.Element == Opacity, Source.Error == Never {
		_ = source.bind(to: reactive.opacity)
		return self
	}
}

// MARK: -
private extension ReactiveExtensions where Base: UIView {
	var isVisible: Bond<Bool> {
		bond { $0.isHidden = !$1 }
	}

	var opacity: Bond<Opacity> {
		bond { $0.opacity = $1 }
	}
}
