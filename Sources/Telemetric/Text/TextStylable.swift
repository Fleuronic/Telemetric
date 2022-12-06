// Copyright © Fleuronic LLC. All rights reserved.

import class UIKit.UIColor
import class UIKit.UILabel
import class UIKit.UITextField
import class UIKit.UITextView
import enum UIKit.NSTextAlignment

public protocol TextStylable: Stylable {
	var textAlignment: NSTextAlignment { get set }
}

// MARK: -
public extension Styled where Value: TextStylable {
	var centered: Self {
		self.textAlignment(.center)
	}

	func textColorAsset<TextColor>(_ textColor: @escaping (TextColor.Type) -> UIColor) -> Self {
		let color = textColor(TextColor.self)
		(value as? UILabel)?.textColor = color
		(value as? UITextField)?.textColor = color
		(value as? UITextView)?.textColor = color
		return self
	}
}
