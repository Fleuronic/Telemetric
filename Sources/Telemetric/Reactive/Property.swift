// Copyright © Fleuronic LLC. All rights reserved.

import ReactiveSwift

public prefix func !(property: Property<Bool>) -> Property<Bool> {
	property.negate()
}
