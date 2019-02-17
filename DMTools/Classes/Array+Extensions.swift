//
//  Created by DaftMobile Sp z o. o.
//  Copyright (c) 2015 DaftMobile. All rights reserved.
//

import Foundation

public extension Array {

	/// The last index of the Array
	public var lastIndex: Int { return self.count - 1 }

	@available(*, deprecated, message: "use remove(value:)")
	/**
	Removes object from array

	- parameter object: The object to be removed
	*/
	public mutating func removeObject<U: Equatable>(_ object: U) {
		remove(value: object)
	}

	/// Removes value from array
	///
	/// - Parameter value: value to remove
	public mutating func remove<U: Equatable>(value: U) {
		if let index = enumerated().first(where: { ($0.element as? U) == value })?.offset {
			remove(at: index)
		}
	}

	/// Remove value from array and return new array
	///
	/// - Parameter value: value to remove
	/// - Returns: array without the value
	public func removing<U: Equatable>(value: U) -> [Element] {
		var new = self
		new.remove(value: value)
		return new
	}

	/**
	Randomizes the order of elements in array
	*/
	public mutating func randomizeOrderInPlace() {
		for _ in 1...10 {
			sort(by: {_, _ -> Bool in
				arc4random() > arc4random()
			})
		}
	}

	/**
	Randomizes the order of elements in array
	- returns: A randomized copy of the Array
	*/
	public func randomizeOrder() -> [Element] {
		var sorted = self
		for _ in 0..<10 {
			sorted = sorted.sorted { _, _ -> Bool in arc4random() > arc4random() }
		}
		return sorted
	}

	/**
	Enumerates the Array with provided closure

	- parameter closure: The closure to run on each element of an array
	*/
	public func enumerateWithClosure(_ closure: (_ element: Element, _ index: Int, _ stop: inout Bool) -> Void) {
		var stop: Bool = false
		for index in 0..<self.count {
			closure(self[index], index, &stop)
			if stop { break }
		}
	}

	/**
	Offsets the Array

	- parameter count: A number to move the 0 index to

	- returns: The array copy offset by *count*
	*/
	public func offset(_ count: Int) -> [Element] {
		var aCopy = self
		aCopy.offsetInPlace(count)
		return aCopy
	}

	/**
	Offsets the Array in place, mutating the original Array

	- parameter count: A number to move the 0 index to
	*/
	public mutating func offsetInPlace(_ count: Int) {
		count.times({
			let element = self.remove(at: 0)
			self.append(element)
		})
	}

}

public extension Array where Element: Equatable {

	/**
	Access the `index`th element safely

	- returns: The `index`th element if exists, nil if not
	*/

	@available(*, deprecated, message: "use [safe: index] subscript")
	public func elementAtIndex(_ index: Int) -> Element? {
		if !((0...lastIndex) ~= index) || count == 0 {
			return nil
		}
		return self[index]
	}

	/**
	Access the element before `elem` in parameter if is contained

	- parameter elem: The element to return one before

	- returns: The element before `elem` if exists, nil if not
	*/

	public func elementBefore(_ elem: Element) -> Element? {
		let prevIndex = ((index(of: elem))! - 1)
		return self[safe: prevIndex]
	}

	/**
	Access the element after `elem` in parameter if is contained

	- parameter elem: The element to return one after

	- returns: The element after `elem` if exists, nil if not
	*/

	public func elementAfter(_ elem: Element) -> Element? {
		let nextIndex = ((index(of: elem))! + 1)
		return self[safe: nextIndex]
	}
}
