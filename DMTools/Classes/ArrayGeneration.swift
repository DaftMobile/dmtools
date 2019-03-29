import Foundation

public extension Int {
	/// Generates `self` element array filled with zeros only. Useful to generate big arrays of known size (using map).
	/// For example wanting to create a new array of 20 UIViews, one would call 20.zeros().map { _ in UIView() }
	/// Instead of creating an array variable and appending elements to it
	/// Don't use it on negative numbers - it will crash.
	///
	/// - Returns: array of zeroes
	func zeros() -> [Int] {
		return [Int](repeating: 0, count: self)
	}

	/// Generates Int array with `self` elements, being consecutive naturals
	/// For example 3.naturals() generates [0, 1, 2]
	///
	/// - Returns: array of consecutive naturals
	func naturals() -> [Int] {
		var values: [Int] = self.zeros()
		for index in 0..<self {
			values[index] = index
		}
		return values
	}
}
