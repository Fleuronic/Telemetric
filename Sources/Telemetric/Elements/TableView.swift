// Copyright © Fleuronic LLC. All rights reserved.

import UIKit
import ReactiveSwift
import ReactiveCocoa
import ReactiveDataSources

import struct Geometric.Styled

public extension Styled where Base: UITableView {
    func items<Item: Equatable & Identifiable>(_ property: Property<[Item]>, text keyPath: KeyPath<Item, String>) -> Base {
        let identifier = String(reflecting: Item.self)
        let dataSource = ReactiveTableViewSectionedAnimatedDataSource<List<Item>> { _, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
            cell.textLabel?.text = item[keyPath: keyPath]
            return cell
        }
        
        objc_setAssociatedObject(base, &dataSourceKey, dataSource, .OBJC_ASSOCIATION_RETAIN)
        base.dataSource = dataSource
        base.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        base.reactive.items(dataSource: dataSource) <~ property.map { [.init(items: $0)] }
        
        return base
    }
    
    func itemSelected<Item: Equatable & Identifiable>(_ target: BindingTarget<Item>) -> Self {
        let delegate = Delegate()
        let dataSource = base.dataSource as! TableViewSectionedDataSource<List<Item>>
        
        objc_setAssociatedObject(base, &delegateKey, delegate, .OBJC_ASSOCIATION_RETAIN)
        base.delegate = delegate
        target <~ delegate.selectRowAtIndexPath.output.map { dataSource[$0] }
        return self
    }
}

// MARK: -
private struct List<Item: Equatable & Identifiable> {
    let items: [Item]
}

// MARK: -
extension List: AnimatableSectionModelType {
	// MARK: Identifiable
	var id: Int { 0 }

    // MARK: SectionModelType
    init(original: Self, items: [Item]) {
        self = original
    }
}

// MARK: -
private class Delegate: NSObject {
    fileprivate let selectRowAtIndexPath = Signal<IndexPath, Never>.pipe()
}

// MARK: -
extension Delegate: UITableViewDelegate {
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectRowAtIndexPath.input.send(value: indexPath)
    }
}

private var delegateKey: Void?
private var dataSourceKey: Void?
