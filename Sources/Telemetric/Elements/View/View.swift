// Copyright © Fleuronic LLC. All rights reserved.

import UIKit
import ReactiveKit
import Bond

import struct Metric.Opacity

public extension ReactiveExtensions where Base: UIView {
	var isVisible: Bond<Bool> {
		bond { $0.isHidden = !$1 }
	}

	var opacity: Bond<Opacity> {
		bond { $0.alpha = $1.value }
	}
}
