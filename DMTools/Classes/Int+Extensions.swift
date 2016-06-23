//
//  Created by DaftMobile Sp z o. o.
//  Copyright (c) 2015 DaftMobile. All rights reserved.
//

import CoreGraphics

public extension Int {
	/**
	* Ensures that the integer value stays with the specified range.
	*/
	public func clamped(range: Range<Int>) -> Int {
		return (self < range.startIndex) ? range.startIndex : ((self >= range.endIndex) ? range.endIndex - 1 : self)
	}

	/**
	* Ensures that the integer value stays with the specified range.
	*/
	public mutating func clamp(range: Range<Int>) -> Int {
		self = clamped(range)
		return self
	}

	/**
	* Ensures that the integer value stays between the given values, inclusive.
	*/
	public func clamped(v1: Int, _ v2: Int) -> Int {
		let min: Int = v1 < v2 ? v1 : v2
		let max: Int = v1 > v2 ? v1 : v2
		return self < min ? min : (self > max ? max : self)
	}

	/**
	* Ensures that the integer value stays between the given values, inclusive.
	*/
	public mutating func clamp(v1: Int, _ v2: Int) -> Int {
		self = clamped(v1, v2)
		return self
	}

	/**
	* Returns a random integer in the specified range.
	*/
	public static func random(range: Range<Int>) -> Int {
		return Int(arc4random_uniform(UInt32(range.endIndex - range.startIndex))) + range.startIndex
	}

	/**
	- parameter n: Top limit of return value
	 - returns: Random integer between 0 and n-1.
	*/
	public static func random(n: Int) -> Int {
		return Int(arc4random_uniform(UInt32(n)))
	}
	
	/**
	* Randomly returns either 1 or -1.
	*/
	public static func randomSign() -> Int {
		return (arc4random_uniform(2) == 0) ? 1 : -1
	}

	/**
		Runs a closure number of times
		- parameter closure: A closure to be performed
	*/
	func times(closure: (Int) -> Void) -> Void {
		for i in 0..<self {
			closure(i)
		}
	}

	/**
	Runs a closure number of times
	- parameter closure:A closure to be performed
	*/

	func times(closure: () -> Void) -> Void {
		for _ in 0..<self {
			closure()
		}
	}
}

extension Int: Randomable {
	public static func random(min min: Int, max: Int) -> Int {
		return RandomTools.randomInt(min: min, max: max)
	}
}

public extension Int {
	public func factorial() -> Int {
		assert(self >= 0, "Cannot compute factorial of a negative number :(")
		var toReturn = 1
		var counter = self
		while counter > 1 {
			toReturn *= counter
			counter -= 1
		}
		return toReturn
	}
}
