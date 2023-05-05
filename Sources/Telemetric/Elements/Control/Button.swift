// Copyright © Fleuronic LLC. All rights reserved.

import UIKit
import DynamicColor
import ReactiveKit
import Bond

import enum Metric.Corner
import struct Metric.Percentage
import struct Metric.Opacity
import struct Metric.Styled

// MARK: -
public extension Styled where Base: UIButton {
	func title<Source: SignalProtocol, Strings>(_ source: Source) -> Self where Source.Element == (Strings.Type) -> String, Source.Error == Never {
		_ = source.map { $0(Strings.self) }.bind(to: base.reactive.title)
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
