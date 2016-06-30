//
//  WeakArray.swift
//  DMTools
//
//  Created by Kajetan Dąbrowski on 30/06/16.
//	Copyright DaftMobile. All rights reserved
//

import Foundation

//MARK: Internal struct used to store weak references

private struct Weak<T: AnyObject> {
	weak var value : T?
	
	init (_ value: T?) {
		self.value = value
	}
}

extension Weak: CustomStringConvertible {
	private var description: String {
		if let value = value { return "\(value)" }
		return "nil"
	}
}

public struct WeakArray<T: AnyObject>: SequenceType, CustomStringConvertible, CustomDebugStringConvertible, ArrayLiteralConvertible {
	
	// MARK: Private
	public typealias Element = T
	private typealias WeakElement = Weak<Element>
	private typealias GeneratorType = AnyGenerator<T>
	private var items = [WeakElement]()
	
	// MARK: Public
	public var description: String {
		return items.description
	}
	public var debugDescription: String {
		return items.debugDescription
	}
	public var count: Int {
		return items.count
	}
	public var isEmpty: Bool {
		return items.isEmpty
	}
	public var first: Element? {
		return items.first?.value
	}
	public var last: Element? {
		return items.last?.value
	}
	
	// MARK: Methods
	
	public init() {}
	
	public init(arrayLiteral elements: Element...) {
		for element in elements {
			append(element)
		}
	}
	
	public func generate() -> AnyGenerator<Element> {
		let values: Array<Element?> = items.map {$0.value}
		var index = 0
		return AnyGenerator<Element>(body: {
			while index < values.count {
				let next = values[index]
				index += 1
				if next != nil {
					return next
				}
			}
			return nil
		})
	}
	
	public subscript(index: Int) -> Element? {
		get {
			return items[index].value
		}
		set(value) {
			items[index] = Weak(value)
		}
	}
	
	
	public mutating func append(value: Element?) {
		items.append(Weak(value))
	}
	
	public mutating func insert(newElement: Element, atIndex i: Int) {
		items.insert(Weak(newElement), atIndex: i)
	}
	
	public mutating func removeAtIndex(index: Int) -> Element? {
		return items.removeAtIndex(index).value
	}
	
	/**
	Removes all nil values. Changes count
	*/
	mutating public func consolidate() {
		var indicesToRemove = [Int]()
		for (index, element) in items.enumerate() {
			if element.value == nil {
				indicesToRemove.insert(index, atIndex: 0)
			}
		}
		for index in indicesToRemove {
			removeAtIndex(index)
		}
	}
	
}
