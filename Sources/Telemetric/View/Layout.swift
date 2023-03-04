// Copyright © Fleuronic LLC. All rights reserved.

import protocol Layoutless.AnyLayout

@resultBuilder public struct LayoutBuilder {
	public static func buildBlock(_ layouts: AnyLayout?...) -> [AnyLayout] {
		layouts.compactMap { $0 }
	}

	public static func buildBlock(_ layouts: [AnyLayout?]) -> [AnyLayout] {
		layouts.compactMap { $0 }
	}
}
