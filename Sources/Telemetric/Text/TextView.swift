// Copyright © Fleuronic LLC. All rights reserved.

import class UIKit.UITextView
import struct ReactiveKit.SafeSignal
import protocol ReactiveKit.ReactiveExtensions

extension UITextView: TextStylable {}

public extension ReactiveExtensions where Base: UITextView {
	var edited: SafeSignal<String> {
		text.ignoreNils().removeDuplicates()
	}
}

