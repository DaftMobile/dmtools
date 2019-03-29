//swiftlint:disable identifier_name
import CoreGraphics

public extension CGFloat {
	/**
	* Converts an angle in degrees to radians.
	*/
    func degreesToRadians() -> CGFloat {
		return .pi * self / 180.0
	}

	/**
	* Converts an angle in radians to degrees.
	*/
    func radiansToDegrees() -> CGFloat {
		return self * 180.0 / .pi
	}

	/**
	* Ensures that the float value stays between the given values, inclusive.
	*/
    func clamped(_ v1: CGFloat, _ v2: CGFloat) -> CGFloat {
		let min: CGFloat = v1 < v2 ? v1 : v2
		let max: CGFloat = v1 > v2 ? v1 : v2
		return self < min ? min : (self > max ? max : self)
	}

	/**
	* Ensures that the float value stays between the given values, inclusive.
	*/
    mutating func clamp(_ v1: CGFloat, _ v2: CGFloat) -> CGFloat {
		self = clamped(v1, v2)
		return self
	}

	/**
	* Returns 1.0 if a floating point value is positive; -1.0 if it is negative.
	*/
    func sign() -> CGFloat {
		return (self >= 0.0) ? CGFloat(1.0) : CGFloat(-1.0)
	}

	/**
	* Returns a random floating point number between 0.0 and 1.0, inclusive.
	*/
    static func random() -> CGFloat {
		return CGFloat(drand48())
	}

	/**
	* Randomly returns either 1.0 or -1.0.
	*/
    static func randomSign() -> CGFloat {
		return (arc4random_uniform(2) == 0) ? 1.0 : -1.0
	}
}

extension CGFloat: Randomable {
	public static func random(min: CGFloat, max: CGFloat) -> CGFloat {
		return RandomTools.randomCGFloat(min: min, max: max)
	}
}

/**
* Returns the shortest angle between two angles. The result is always between
* -π and π.
*/
public func shortestAngleBetween(_ angle1: CGFloat, angle2: CGFloat) -> CGFloat {
	let twoπ: CGFloat = .pi * 2.0
	var angle: CGFloat = (angle2 - angle1).truncatingRemainder(dividingBy: twoπ)
	if angle >= .pi { angle -= twoπ }
	if angle <= -.pi { angle += twoπ }
	return angle
}

public func sign(_ value: CGFloat) -> CGFloat {
	if value >= 0.0 { return 1.0 } else { return -1.0 }
}
