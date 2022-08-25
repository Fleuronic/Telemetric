// Copyright © Fleuronic LLC. All rights reserved.

import UIKit
import ReactiveKit

public extension UIButton {
	func title<Source: SignalProtocol, Strings>(_ source: Source) -> Self where Source.Element == (Strings.Type) -> String, Source.Error == Never {
		_ = source.map { $0(Strings.self) }.bind(to: reactive.title)
		return self
	}

	func enabled<Source: SignalProtocol>(_ source: Source) -> Self where Source.Element == Bool, Source.Error == Never {
		_ = source.bind(to: reactive.isEnabled)
		return self
	}

	static func tap<Target: BindableProtocol>(_ target: Target) -> UIButton where Target.Element == Void {
		let button = UIButton()
		_ = target.bind(signal: button.reactive.tap)
		return button
	}
}
