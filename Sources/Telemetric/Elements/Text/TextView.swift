// Copyright © Fleuronic LLC. All rights reserved.

import UIKit
import ReactiveKit

import protocol Metric.Text

extension UITextView: Text {}

// MARK: -
public extension ReactiveExtensions where Base: UITextView {
	var edited: SafeSignal<String> {
		text.ignoreNils().removeDuplicates()
	}
}
