// Copyright © Fleuronic LLC. All rights reserved.

import UIKit
import ReactiveKit

import struct Metric.Styled
import protocol Metric.Text

extension UILabel: Text {}

// MARK: -
public extension Styled where Base: UILabel {
	func text<Source: SignalProtocol, Strings>(_ source: Source) -> UILabel where Source.Element == (Strings.Type) -> String, Source.Error == Never {
		_ = source.map { $0(Strings.self) }.bind(to: base.reactive.text)
		return base
	}
}
