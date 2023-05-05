// Copyright © Fleuronic LLC. All rights reserved.

import UIKit
import ReactiveKit
import Bond

import struct Metric.Styled

public extension Styled where Base: UITextField {
	func placeholder<Source: SignalProtocol, Strings>(_ source: Source) -> Self where Source.Element == (Strings.Type) -> String, Source.Error == Never {
		self.placeholder(source.map { $0(Strings.self) })
	}
}

// MARK: -
public extension ReactiveExtensions where Base: UITextField {
	var edited: SafeSignal<String> {
		text.ignoreNils().removeDuplicates()
	}
}

// MARK: -
private extension ReactiveExtensions where Base: UITextField {
	var placeholder: Bond<String> {
		bond { $0.placeholder = $1 }
	}
}
