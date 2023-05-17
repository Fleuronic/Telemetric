// Copyright © Fleuronic LLC. All rights reserved.

import UIKit
import ReactiveSwift
import ReactiveCocoa

import struct Geometric.Styled

public extension Styled where Base: UILabel {
	func text(_ property: Property<String>) -> Base {
		base.reactive.text <~ property
		return base
	}

	func text<Strings>(_ property: Property<(Strings.Type) -> String>) -> Base {
		text(property.map { $0(Strings.self) } )
	}
}
