import Foundation

public protocol Mutable { }

public extension Mutable {
	func mutate(transform: (inout Self) throws -> Void) rethrows -> Self {
		var newSelf = self
		try transform(&newSelf)
		return newSelf
	}
}
