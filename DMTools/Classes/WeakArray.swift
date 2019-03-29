import Foundation

// MARK: Internal struct used to store weak references

private struct Weak<T: AnyObject> {
	weak var value: T?

	init (_ value: T?) {
		self.value = value
	}
}

extension Weak: CustomStringConvertible {
	fileprivate var description: String {
		if let value = value { return "\(value)" }
		return "nil"
	}
}

public struct WeakArray<T: AnyObject>: Sequence, ExpressibleByArrayLiteral {

	// MARK: Private
	public typealias Element = T
	fileprivate typealias WeakElement = Weak<Element>
	fileprivate typealias GeneratorType = AnyIterator<T>
	fileprivate var items = [WeakElement]()

	// MARK: Public
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

	public func makeIterator() -> AnyIterator<Element> {
		let values = items.map { $0.value }
		var index = 0
		return AnyIterator<Element>({
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

	public mutating func append(_ value: Element?) {
		items.append(Weak(value))
	}

	public mutating func insert(_ newElement: Element, atIndex index: Int) {
		items.insert(Weak(newElement), at: index)
	}

	public mutating func removeAtIndex(_ index: Int) -> Element? {
		return items.remove(at: index).value
	}

	/**
	Removes all nil values. Changes count
	*/
	mutating public func consolidate() {
		var indicesToRemove = [Int]()
		for (index, element) in items.enumerated() where element.value == nil {
			indicesToRemove.insert(index, at: 0)
		}
		for index in indicesToRemove {
			_ = removeAtIndex(index)
		}
	}
}

extension WeakArray: CustomStringConvertible, CustomDebugStringConvertible {
	public var description: String {
		return items.description
	}
	public var debugDescription: String {
		return items.debugDescription
	}
}
