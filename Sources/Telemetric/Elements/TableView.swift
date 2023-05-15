// Copyright © Fleuronic LLC. All rights reserved.

import UIKit

import struct Metric.Styled

public extension Styled where Base: UITableView {
//	func rowSelected<Target: BindableProtocol>(_ target: Target) -> Self where Target.Element == Int {
//		_ = target.bind(signal: base.reactive.selectedRowIndexPath.map(\.row))
//		return self
//	}
//
//	func rowDeleted<Target: BindableProtocol>(_ target: Target) -> Self where Target.Element == Int {
//		_ = target.bind(signal: base.reactive.deletedRowIndexPath.map(\.row))
//		return self
//	}
//
//	func cellsText<Source: SignalProtocol>(_ source: Source) -> UITableView where Source.Element == [String], Source.Error == Never {
//		_ = source.diff().bind(to: base, cellType: UITableViewCell.self) { $0.textLabel?.text = $1 }
//		return base
//	}
}

// MARK: -
//private extension ReactiveExtensions where Base: UITableView {
//	var deletedRowIndexPath: SafeSignal<IndexPath> {
//		return dataSource.signal(for: #selector(UITableViewDataSource.tableView(_:commit:forRowAt:))) { (subject: PassthroughSubject<IndexPath, Never>, _: UITableView, editingStyle: UITableViewCell.EditingStyle.RawValue, indexPath: IndexPath) in
//			guard case .delete = UITableViewCell.EditingStyle(rawValue: editingStyle) else { return }
//			subject.send(indexPath)
//		}
//	}
//}
