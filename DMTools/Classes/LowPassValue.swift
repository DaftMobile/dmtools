import Foundation

public struct LowPassFilterSignal<T: FloatingPoint> {
	/// Current signal value
	public private(set) var value: T

	/// A scaling factor in the range 0.0..<1.0 that determines
	/// how resistant the value is to change
	public let filterFactor: T

	/// Update the value, using filterFactor to attenuate changes
	public mutating func update(newValue: T) {
		value = filterFactor * value + (T(1) - filterFactor) * newValue
	}

	public init(value: T, filterFactor: T) {
		self.value = value
		self.filterFactor = filterFactor
	}
}

extension LowPassFilterSignal: CustomDebugStringConvertible {
	public var debugDescription: String {
		return (value as? CustomDebugStringConvertible)?.debugDescription ?? "Low pass value"
	}
}

extension LowPassFilterSignal: Equatable {
	public static func == (lhs: LowPassFilterSignal, rhs: LowPassFilterSignal) -> Bool {
		return lhs.value == rhs.value && lhs.filterFactor == rhs.filterFactor
	}
}
