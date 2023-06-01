// Copyright © Fleuronic LLC. All rights reserved.

import UIKit
import Foundation
import ReactiveSwift

final class Delegate: NSObject {
    private let shouldHighlightRow: (IndexPath) -> Bool
	private let selectedIndexPathPipe = Signal<IndexPath, Never>.pipe()
    
    init(shouldHighlightRow:  @escaping (IndexPath) -> Bool) {
        self.shouldHighlightRow = shouldHighlightRow
    }
}

extension Delegate {
	var selectedIndexPath: Signal<IndexPath, Never> {
		selectedIndexPathPipe.output
	}
}

// MARK: -
extension Delegate: UITableViewDelegate {
	// MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        shouldHighlightRow(indexPath)
    }
    
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		selectedIndexPathPipe.input.send(value: indexPath)
	}
	
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		(cell as? UITableView.LoadingCell)?.load()
	}
}
