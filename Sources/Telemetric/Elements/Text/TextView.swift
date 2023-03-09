// Copyright © Fleuronic LLC. All rights reserved.

import UIKit
import ReactiveKit

extension UITextView: TextStylable {}

// MARK: -
public extension ReactiveExtensions where Base: UITextView {
	var edited: SafeSignal<String> {
		text.ignoreNils().removeDuplicates()
	}
}
