// Copyright © Fleuronic LLC. All rights reserved.

import UIKit
import Layoutless

extension UITableView {
	final class LoadingCell: UITableViewCell {
		private let spinner = UIActivityIndicatorView(style: .medium)
		
		override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
			super.init(style: style, reuseIdentifier: reuseIdentifier)
			
			spinner
				.centeringHorizontallyInParent()
				.stickingToParentEdges(top: .exactly(12), bottom: .exactly(12))
				.layout(in: contentView)
		}
		
		required init(coder: NSCoder) { fatalError() }
	}
}

// MARK: -
extension UITableView.LoadingCell {
	func load() {
		spinner.startAnimating()
	}
}
