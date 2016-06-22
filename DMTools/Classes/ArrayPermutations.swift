//
//  Permutations.swift
//
//	Copyright © 2016 DaftMobile. All rights reserved.
//

import Foundation


public extension Array {
	private static func generatePermutation<T>(n: Int, a: [T], inout current: [[T]]) {
		var a = a
		if n == 1 {
			current.append(a)
		} else {
			for i in 0..<n-1 {
				generatePermutation(n-1, a: a, current: &current)
				if n % 2 == 1 {
					swap(&a[i], &a[n-1])
				} else {
					swap(&a[0], &a[n-1])
				}
			}
			generatePermutation(n-1, a: a, current: &current)
		}
	}

	public func generatePermutations() -> [[Element]] {
		if isEmpty { return [[Element]]() }
		var toReturn = [[Element]]()
		Array.generatePermutation(self.count, a: self, current: &toReturn)
		return toReturn
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