// Copyright © Fleuronic LLC. All rights reserved.

import UIKit
import ReactiveSwift
import ReactiveCocoa
import ReactiveDataSources

import struct Geometric.Styled

public extension Styled where Base: UITableView {
	func content<Item: Equatable & Identifiable>(
        items: Property<[Item]>,
        text: KeyPath<Item, String>,
        loading: Property<Bool> = .init(value: false),
        canSelectItem: @escaping (Item) -> Bool = { _ in true }
    ) -> Self {
		let itemIdentifier = String(reflecting: Item.self)
		let loadingIdentifier = String(reflecting: UITableView.LoadingCell.self)
		let dataSource = ReactiveTableViewSectionedAnimatedDataSource<List<Item>> { _, tableView, indexPath, row in
			let cell: UITableViewCell
            switch row.content {
			case let .item(item):
				cell = tableView.dequeueReusableCell(withIdentifier: itemIdentifier, for: indexPath)
				
				var configuration = cell.defaultContentConfiguration()
				configuration.text = item[keyPath: text]
				cell.contentConfiguration = configuration
                cell.accessoryType = row.isSelectable ? .disclosureIndicator : .none
			case .loading:
				cell = tableView.dequeueReusableCell(withIdentifier: loadingIdentifier, for: indexPath)
			}
			return cell
		}
		
		objc_setAssociatedObject(base, &dataSourceKey, dataSource, .OBJC_ASSOCIATION_RETAIN)
		base.dataSource = dataSource
		base.register(UITableViewCell.self, forCellReuseIdentifier: itemIdentifier)
		base.register(UITableView.LoadingCell.self, forCellReuseIdentifier: loadingIdentifier)
		base.reactive.items(dataSource: dataSource) <~ items.combineLatest(with: loading).map {
			[
                List(
                    items: $0.0,
                    isLoading: $0.1,
                    canSelectItem: canSelectItem
                )
            ]
		}
		
		return self
	}
	
	func itemSelected<Item: Equatable & Identifiable>(_ target: BindingTarget<Item>) -> Base {
		let dataSource = base.dataSource as! TableViewSectionedDataSource<List<Item>>
        let delegate = Delegate(
            shouldHighlightRow: { dataSource[$0].isSelectable }
        )

		objc_setAssociatedObject(base, &delegateKey, delegate, .OBJC_ASSOCIATION_RETAIN)
		base.delegate = delegate
		target <~ delegate.selectedIndexPath.compactMap {
            switch dataSource[$0].content {
			case .loading:
				return nil
			case let .item(item):
				return item
			}
		}
		return base
	}
}

private var delegateKey: Void?
private var dataSourceKey: Void?
