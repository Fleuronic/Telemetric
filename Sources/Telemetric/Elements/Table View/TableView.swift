// Copyright © Fleuronic LLC. All rights reserved.

import UIKit
import ReactiveSwift
import ReactiveCocoa
import ReactiveDataSources

import struct Geometric.Styled

public extension Styled where Base: UITableView {
    func items<Item: Equatable & Identifiable>(_ property: Property<[Item]>, text keyPath: KeyPath<Item, String>, loading: Property<Bool> = .init(value: false)) -> Self {
        let itemIdentifier = String(reflecting: Item.self)
        let loadingIdentifier = String(reflecting: UITableView.LoadingCell.self)
        let dataSource = ReactiveTableViewSectionedReloadDataSource<List<Item>> { _, tableView, indexPath, item in
            let cell: UITableViewCell
            switch item {
            case let .item(item):
                cell = tableView.dequeueReusableCell(withIdentifier: itemIdentifier, for: indexPath)
                
                var configuration = cell.defaultContentConfiguration()
                configuration.text = item[keyPath: keyPath]
                cell.contentConfiguration = configuration
            case .loading:
                cell = tableView.dequeueReusableCell(withIdentifier: loadingIdentifier, for: indexPath)
            }
            return cell
        }
        
        objc_setAssociatedObject(base, &dataSourceKey, dataSource, .OBJC_ASSOCIATION_RETAIN)
        base.dataSource = dataSource
        base.register(UITableViewCell.self, forCellReuseIdentifier: itemIdentifier)
        base.register(UITableView.LoadingCell.self, forCellReuseIdentifier: loadingIdentifier)
        base.reactive.items(dataSource: dataSource) <~ property.combineLatest(with: loading).map {
            [List(items: $0.0, isLoading: $0.1)]
        }
        
        return self
    }
    
    func itemSelected<Item: Equatable & Identifiable>(_ target: BindingTarget<Item>) -> Base {
        let delegate = Delegate()
        let dataSource = base.dataSource as! TableViewSectionedDataSource<List<Item>>
        
        objc_setAssociatedObject(base, &delegateKey, delegate, .OBJC_ASSOCIATION_RETAIN)
        base.delegate = delegate
        target <~ delegate.selectedIndexPath.compactMap {
            switch dataSource[$0] {
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
