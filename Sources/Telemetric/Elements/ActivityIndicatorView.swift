// Copyright © Fleuronic LLC. All rights reserved.

import UIKit
import ReactiveSwift

import struct Geometric.Styled

public extension Reactive where Base: UIActivityIndicatorView {
    var indicatesActivity: BindingTarget<Bool> {
        makeBindingTarget {
            _ = $1 ? $0.startAnimating() : $0.stopAnimating()
        }
    }
}
