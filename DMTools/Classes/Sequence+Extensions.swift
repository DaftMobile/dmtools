import Foundation

public extension Sequence {
	func group<U: Hashable>(by key: (Iterator.Element) -> U) -> [U: [Iterator.Element]] {
		var categories: [U: [Iterator.Element]] = [:]
		for element in self {
			let key = key(element)
			if case nil = categories[key]?.append(element) {
				categories[key] = [element]
			}
		}
		return categories
	}

	func divide(predicate: (Self.Iterator.Element) -> Bool) -> (slice: [Self.Iterator.Element], remainder: [Self.Iterator.Element]) {
		var slice: [Self.Iterator.Element] = []
		var remainder: [Self.Iterator.Element] = []
		forEach {
			switch predicate($0) {
			case true : slice.append($0)
			case false : remainder.append($0)
			}
		}
		return (slice, remainder)
	}
}
