import Foundation
import CoreGraphics

open class RandomTools {

	open class func randomBool() -> Bool {
		return (self.randomInt(min: 0, max: 1) == 0) ? false : true
	}

	open class func randomBool(probability: Double) -> Bool {
		if probability <= 0.0 { return false }
		if probability >= 1.0 { return true }

		return randomDouble(0.0, max: 1.0) <= probability
	}

	open class func randomInt(min: Int, max: Int) -> Int {
		assert(max >= min, "Max should be greater than min")
		if max == min {
			return min
		}
		let result = arc4random() % UInt32(max - min + 1)
		return Int(result) + min
	}

	open class func randomElementFromArray<T>(_ array: [T]) -> T {
		return array.randomElement()!
	}

	open class func randomCGFloat(min: CGFloat, max: CGFloat) -> CGFloat {
		let result = randomDouble(Double(min), max: Double(max))
		return CGFloat(result)
	}

	open class func randomTimeInterval(_ min: TimeInterval, max: TimeInterval) -> TimeInterval {
		return TimeInterval(randomDouble(Double(min), max: Double(max)))
	}

	open class func randomDouble(_ min: Double, max: Double) -> Double {
		if min > max { fatalError("Random Double: min > max") }
		let result = drand48() * (max - min)
		return result + min
	}

	open class func randomElementFromArray<T>(_ elements: [T], withCorespondingProbabilities probabilities: [Double]) -> T {
		assert(elements.count == probabilities.count)
		assert(probabilities.filter({ $0 < 0.0 }).count == 0)
		assert(probabilities.reduce(0.0, +) > 0.0)

		let count: Int = elements.count
		var accumulatedProbabilities = [Double](repeating: 0.0, count: count)
		accumulatedProbabilities[0] = probabilities[0]
		for index in 1..<count {
			accumulatedProbabilities[index] = probabilities[index] + accumulatedProbabilities[index - 1]
		}

		let maxValue: Double = accumulatedProbabilities[count - 1]

		let randomlyGeneratedNumber: Double = randomDouble(0.0, max: maxValue)
		var generatedIndex: Int = 0
		while accumulatedProbabilities[generatedIndex] < randomlyGeneratedNumber {
			generatedIndex += 1
		}

		return elements[generatedIndex]
	}

	open class func randomObjectWithProbpabilities(_ tuples: [(Any, Double)]) -> Any {
		var tuples = tuples.sorted { $0.1 < $1.1 }

		let probabilitySum: Double = tuples.reduce(0.0, { $0 + $1.1 })
		var previousProb: Double = 0.0
		let probabilities: [Double] = tuples.map({
			var value = $0.1 / probabilitySum
			value += previousProb
			previousProb = value
			return value
		})

		let randomValue = randomDouble(0.0, max: 1.0)
		let value = probabilities.first(where: { $0 >= randomValue })!

		let index = probabilities.firstIndex(of: value)!

		return tuples[index].0
	}

	open class func randomCGSize(_ minSide: CGFloat, maxSide: CGFloat) -> CGSize {
		assert(maxSide >= minSide, "Max should be greater than min")
		let width: CGFloat = randomCGFloat(min: minSide, max: maxSide)
		let height: CGFloat = randomCGFloat(min: minSide, max: maxSide)
		return CGSize(width: width, height: height)
	}

	open class func randomPointInRect(_ rect: CGRect) -> CGPoint {
		let xCoordinate = randomCGFloat(min: rect.minX, max: rect.maxX)
		let yCoordinate = randomCGFloat(min: rect.minY, max: rect.maxY)
		return CGPoint(x: xCoordinate, y: yCoordinate)
	}

	open class func randomPointInSize(_ size: CGSize) -> CGPoint {
		return randomPointInRect(CGRect(origin: CGPoint.zero, size: size))
	}
}

public extension Array {
	func randomElement() -> Element? {
		if self.isEmpty { return nil }
		return self[RandomTools.randomInt(min: 0, max: lastIndex)]
	}

	func randomElementWithCorespondingProbabilities(_ probabilities: [Double]) -> Element {
		return RandomTools.randomElementFromArray(self, withCorespondingProbabilities: probabilities)
	}

	func randomElements(count: Int) -> [Element] {
		if count == 0 { return [Element]() }
		assert(self.count >= count, "Cannot draw \(count) elements from an array with \(self.count) element!")
		return [Element]((self.randomizeOrder())[0..<count])
	}
}

public protocol Randomable {
	static func random(min: Self, max: Self) -> Self
}
