// Copyright © Fleuronic LLC. All rights reserved.

import ReactiveDataSources

struct List<Item: Equatable & Identifiable> {
    fileprivate let rows: [Row]
}

// MARK: -
extension List {
    enum Row {
        case item(Item)
        case loading
    }
    
    init(
        items: [Item],
        isLoading: Bool
    ) {
        rows = isLoading ? [.loading] : items.map(Row.item)
    }
}

// MARK: -
extension List: SectionModelType {
    var items: [Row] { rows }
    
    // MARK: SectionModelType
    init(original: Self, items: [Row]) {
        self = original
    }
}
