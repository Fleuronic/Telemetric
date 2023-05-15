// Copyright © Fleuronic LLC. All rights reserved.

import UIKit
import ReactiveSwift
import ReactiveCocoa

import struct Metric.Styled

public extension Styled where Base: UIButton {
	func action(_ target: BindingTarget<Void>) -> Base {
		target <~ base.reactive.controlEvents(.touchUpInside).map { _ in }
		return base
	}

	func title(_ property: Property<String>) -> Self {
		base.reactive.title <~ property
		return self
	}

	func title<Strings>(_ property: Property<(Strings.Type) -> String>) -> Self {
		title(property.map { $0(Strings.self) })
	}
}

// MARK: -
public extension Reactive where Base: UIButton {
	var showsActivity: BindingTarget<Bool> {
		makeBindingTarget {
			$0.setTitle($1 ? .init() : $0.currentTitle, for: .normal)
			$0.configuration?.showsActivityIndicator = $1
		}
	}
}
