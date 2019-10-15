import Foundation

/// Mutable. Conforming to this protocol allows you to call the `mutate` function.
public protocol Mutable { }

public extension Mutable {
	/// Mutates a value and returns the new, mutated version.
	///  ```
	///  var foo = Foo(bar: "old", arg1: 1, arg2: ...)
	///  foo = foo.mutate { $0.bar = "new value" }
	///  ```
	///
	/// This way you don't have to use complex constructors to mutate simple data classes
	/// It returns the new, mutated value for value types,
	/// and returns the same, mutated instance for reference types.
	func mutate(transform: (inout Self) throws -> Void) rethrows -> Self {
		var newSelf = self
		try transform(&newSelf)
		return newSelf
	}
}
