//
//  Created by DaftMobile Sp z o. o.
//  Copyright (c) 2015 DaftMobile. All rights reserved.
//

import Foundation

public extension Array {

	/// The last index of the Array
	public var lastIndex: Int { return self.count - 1 }

	/**
	Removes object from array

	- parameter object: The object to be removed
	*/
	public mutating func removeObject<U: Equatable>(object: U) {
		var index: Int?
		for (idx, objectToCompare) in self.enumerate() {
			if let to = objectToCompare as? U {
				if object == to {
					index = idx
				}
			}
		}
		if index != nil {
			self.removeAtIndex(index!)
		}
	}


	/**
	Randomizes the order of elements in array
	*/
	public mutating func randomizeOrderInPlace() {
		for _ in 1...10 {
			sortInPlace({(_,_) -> Bool in
				arc4random() > arc4random()
			})
		}
	}

	/**
	Randomizes the order of elements in array
	- returns: A randomized copy of the Array
	*/
	@warn_unused_result(mutable_variant="randomizeOrderInPlace")
	public func randomizeOrder() -> Array<Element> {
		var sorted = self
		for _ in 0..<10 {
			sorted = sorted.sort{(_,_) -> Bool in arc4random() > arc4random()}
		}
		return sorted
	}

	/**
	Enumerates the Array with provided closure

	- parameter closure: The closure to run on each element of an array
	*/
	public func enumerateWithClosure(closure: (element: Element, index: Int, inout stop: Bool) -> Void) -> Void {
		var stop: Bool = false
		for i in 0..<self.count {
			closure(element: self[i], index: i, stop: &stop)
			if stop {break}
		}
	}

	/**
	Offsets the Array

	- parameter count: A number to move the 0 index to

	- returns: The array copy offset by *count*
	*/
	@warn_unused_result(mutable_variant="offsetInPlace")
	public func offset(count: Int) -> [Element] {
		var aCopy = self
		aCopy.offsetInPlace(count)
		return aCopy
	}

	/**
	Offsets the Array in place, mutating the original Array

	- parameter count: A number to move the 0 index to
	*/
	public mutating func offsetInPlace(count: Int) -> Void {
		count.times({
			let element = self.removeAtIndex(0)
			self.append(element)
		})
	}

}
