import Foundation

extension Array where Element: Equatable {
	public func uniq() -> [Element] {
		return reduce([]) { current, next in
			if current.contains(next) { return current }
			return current + [next]
		}
	}
}
