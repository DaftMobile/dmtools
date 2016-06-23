//
//  Created by DaftMobile Sp z o. o.
//  Copyright (c) 2015 DaftMobile. All rights reserved.
//

import Foundation
import CoreGraphics

public class RandomTools {

	public class func randomBool() -> Bool {
		return (self.randomInt(min: 0, max: 1) == 0) ? false : true
	}
	
	public class func randomBool(probability probability: Double) -> Bool {
		if probability <= 0.0 { return false }
		if probability >= 1.0 { return true }

		return randomDouble(0.0, max: 1.0) <= probability
	}
	
	public class func randomInt(min min: Int, max: Int) -> Int {
		assert(max >= min, "Max should be greater than min")
		if max == min {
			return min
		}
		let result = random() % (max - min + 1)
		return result + min
	}
	
	public class func randomElementFromArray<T>(array: Array<T>) -> T {
		return array.randomElement()!
	}
	
	public class func randomCGFloat(min min: CGFloat, max: CGFloat) -> CGFloat {
		let result = randomDouble(Double(min), max: Double(max))
		return CGFloat(result)
	}
	
	public class func randomTimeInterval(min: NSTimeInterval, max: NSTimeInterval) -> NSTimeInterval {
		return NSTimeInterval(randomDouble(Double(min), max: Double(max)))
	}
	
	public class func randomDouble(min: Double, max: Double) -> Double {
		if min > max { fatalError("Random Double: min > max") }
		let result = drand48() * (max - min)
		return result + min
	}
	
	public class func randomElementFromArray<T>(elements: Array<T>, withCorespondingProbabilities probabilities: Array<Double>) -> T {
		assert(elements.count == probabilities.count)
		assert(probabilities.filter({$0 < 0.0}).count == 0)
		assert(probabilities.reduce(0.0, combine: +) > 0.0)
		
		let count: Int = elements.count
		var accumulatedProbabilities: [Double] = Array<Double>(count: count, repeatedValue: 0.0)
		accumulatedProbabilities[0] = probabilities[0]
		for i in 1..<count {
			accumulatedProbabilities[i] = probabilities[i] + accumulatedProbabilities[i-1]
		}
		
		let maxValue: Double = accumulatedProbabilities[count-1]
		
		let randomlyGeneratedNumber: Double = randomDouble(0.0, max: maxValue)
		var generatedIndex: Int = 0
		while accumulatedProbabilities[generatedIndex] < randomlyGeneratedNumber {
			generatedIndex += 1
		}
		
		return elements[generatedIndex]
	}
	
	public class func randomObjectWithProbpabilities(tuples: [(Any, Double)]) -> Any {
		var tuples = tuples.sort { $0.1 < $1.1 }

		let probabilitySum: Double = tuples.reduce(0.0, combine: { $0 + $1.1 })
		var previousProb: Double = 0.0
		let probabilities: [Double] = tuples.map({
			var value = $0.1 / probabilitySum
			value = value + previousProb
			previousProb = value
			return value
		})
		
		let randomValue = randomDouble(0.0, max: 1.0)
		let value = probabilities.filter({ $0 >= randomValue }).first!
		
		let index = probabilities.indexOf(value)!
		
		return tuples[index].0
	}
	
	public class func randomCGSize(minSide: CGFloat, maxSide: CGFloat) -> CGSize {
		assert(maxSide >= minSide, "Max should be greater than min")
		let width: CGFloat = randomCGFloat(min: minSide, max: maxSide)
		let height: CGFloat = randomCGFloat(min: minSide, max: maxSide)
		return CGSizeMake(width, height)
	}
	

	public class func randomPointInRect(rect: CGRect) -> CGPoint {
		let x = randomCGFloat(min: rect.minX, max: rect.maxX)
		let y = randomCGFloat(min: rect.minY, max: rect.maxY)
		return CGPoint(x: x, y: y)
	}
	
	public class func randomPointInSize(size: CGSize) -> CGPoint {
		return randomPointInRect(CGRect(origin: CGPoint.zero, size: size))
	}
}


public extension Array
{
	public func randomElement() -> Element? {
		if self.isEmpty { return nil }
		return self[RandomTools.randomInt(min: 0, max: lastIndex)]
	}
	
	public func randomElementWithCorespondingProbabilities(probabilities: [Double]) -> Element {
		return RandomTools.randomElementFromArray(self, withCorespondingProbabilities: probabilities)
	}
	
	public func randomElements(count count: Int) -> Array<Element> {
		if count == 0 { return Array<Element>() }
		assert(self.count >= count, "Cannot draw \(count) elements from an array with \(self.count) element!")
		return Array<Element>((self.randomizeOrder())[0..<count])
	}
}

public protocol Randomable {
	static func random(min min: Self, max: Self) -> Self
}
