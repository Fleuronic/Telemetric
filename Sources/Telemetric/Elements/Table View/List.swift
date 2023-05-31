// Copyright © Fleuronic LLC. All rights reserved.

import ReactiveDataSources

struct List<Item: Equatable & Identifiable> {
	fileprivate let rows: [Row]
}

// MARK: -
extension List {
    struct Row: Equatable {
        let content: Content
        let isSelectable: Bool
	}
	
	init(
		items: [Item],
		isLoading: Bool,
        canSelectItem: (Item) -> Bool
	) {
        rows = isLoading ? [.loading] : items.map { item in
            .init(
                content: .item(item),
                isSelectable: canSelectItem(item)
            )
        }
	}
}

// MARK: -
extension List: AnimatableSectionModelType {
	var items: [Row] { rows }
    
    // MARK: Identifiable
    var id: Int { 0 }
	
	// MARK: SectionModelType
	init(original: Self, items: [Row]) {
		self = original
	}
}

extension List.Row {
    enum Content: Equatable {
        case item(Item)
        case loading
    }
    
    static var loading: Self {
        .init(
            content: .loading,
            isSelectable: false
        )
    }
}

// MARK: -
extension List.Row: Identifiable {
    var id: AnyHashable {
        switch content {
        case let .item(item):
            return item.id
        case .loading:
            return 0
        }
    }
}
