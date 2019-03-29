import Foundation

public extension Int {
	/**
	* Ensures that the integer value stays with the specified range.
	*/
	func clamped(_ range: Range<Int>) -> Int {
		return (self < range.lowerBound) ? range.lowerBound : ((self >= range.upperBound) ? range.upperBound - 1 : self)
	}

	/**
	* Ensures that the integer value stays with the specified range.
	*/
	mutating func clamp(_ range: Range<Int>) -> Int {
		self = clamped(range)
		return self
	}

	/**
	* Ensures that the integer value stays between the given values, inclusive.
	*/
	func clamped(_ value1: Int, _ value2: Int) -> Int {
		let min = value1 < value2 ? value1 : value2
		let max = value1 > value2 ? value1 : value2
		return self < min ? min : (self > max ? max : self)
	}

	/**
	* Ensures that the integer value stays between the given values, inclusive.
	*/
	mutating func clamp(_ value1: Int, _ value2: Int) -> Int {
		self = clamped(value1, value2)
		return self
	}

	/**
	* Returns a random integer in the specified range.
	*/
	static func random(_ range: Range<Int>) -> Int {
		return Int(arc4random_uniform(UInt32(range.upperBound - range.lowerBound))) + range.lowerBound
	}

	/**
	- parameter n: Top limit of return value
	- returns: Random integer between 0 and upper-1.
	*/
	static func random(_ upper: Int) -> Int {
		return Int(arc4random_uniform(UInt32(upper)))
	}

	/**
	* Randomly returns either 1 or -1.
	*/
	static func randomSign() -> Int {
		return (arc4random_uniform(2) == 0) ? 1 : -1
	}

	/**
	Runs a closure number of times
	- parameter closure: A closure to be performed
	*/
	func times(_ closure: (Int) -> Void) {
		for index in 0..<self { closure(index) }
	}

	/**
	Runs a closure number of times
	- parameter closure:A closure to be performed
	*/

	func times(_ closure: () -> Void) {
		for _ in 0..<self { closure() }
	}
}

extension Int: Randomable {
	public static func random(min: Int, max: Int) -> Int {
		return RandomTools.randomInt(min: min, max: max)
	}
}

public extension Int {
	func factorial() -> Int {
		assert(self >= 0, "Cannot compute factorial of a negative number")
		var toReturn = 1
		var counter = self
		while counter > 1 {
			toReturn *= counter
			counter -= 1
		}
		return toReturn
	}
}
