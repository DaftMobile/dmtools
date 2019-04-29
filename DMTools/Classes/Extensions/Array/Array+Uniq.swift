import Foundation

extension Array where Element: Equatable {
	func uniq() -> [Element] {
		return reduce([]) { current, next in
			if current.contains(next) { return current }
			return current + [next]
		}
	}
}
