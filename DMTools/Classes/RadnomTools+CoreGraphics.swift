#if os(iOS) || os(macOS)
import Foundation
import CoreGraphics

extension RandomTools {
	open class func randomCGFloat(min: CGFloat, max: CGFloat) -> CGFloat {
		let result = randomDouble(Double(min), max: Double(max))
		return CGFloat(result)
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

#endif
