//
//  Created by DaftMobile Sp z o. o.
//  Copyright (c) 2015 DaftMobile. All rights reserved.
//

import CoreGraphics

public let pi = CGFloat(M_PI)
public let pi2 = CGFloat(M_PI / Double(2))
public let pi3 = CGFloat(M_PI / Double(3))
public let pi4 = CGFloat(M_PI / Double(4))
public let pi5 = CGFloat(M_PI / Double(5))
public let pi6 = CGFloat(M_PI / Double(6))
public let pi7 = CGFloat(M_PI / Double(7))
public let pi8 = CGFloat(M_PI / Double(8))
public let pi9 = CGFloat(M_PI / Double(9))
public let pi10 = CGFloat(M_PI / Double(10))

public extension CGFloat {
	/**
	* Converts an angle in degrees to radians.
	*/
	public func degreesToRadians() -> CGFloat {
		return pi * self / 180.0
	}

	/**
	* Converts an angle in radians to degrees.
	*/
	public func radiansToDegrees() -> CGFloat {
		return self * 180.0 / pi
	}

	/**
	* Ensures that the float value stays between the given values, inclusive.
	*/
	public func clamped(v1: CGFloat, _ v2: CGFloat) -> CGFloat {
		let min: CGFloat = v1 < v2 ? v1 : v2
		let max: CGFloat = v1 > v2 ? v1 : v2
		return self < min ? min : (self > max ? max : self)
	}

	/**
	* Ensures that the float value stays between the given values, inclusive.
	*/
	public mutating func clamp(v1: CGFloat, _ v2: CGFloat) -> CGFloat {
		self = clamped(v1, v2)
		return self
	}

	/**
	* Returns 1.0 if a floating point value is positive; -1.0 if it is negative.
	*/
	public func sign() -> CGFloat {
		return (self >= 0.0) ? CGFloat(1.0) : CGFloat(-1.0)
	}

	/**
	* Returns a random floating point number between 0.0 and 1.0, inclusive.
	*/
	public static func random() -> CGFloat {
		return CGFloat(drand48())
	}

	/**
	* Randomly returns either 1.0 or -1.0.
	*/
	public static func randomSign() -> CGFloat {
		return (arc4random_uniform(2) == 0) ? 1.0 : -1.0
	}
}

extension CGFloat: Randomable {
	public static func random(min min: CGFloat, max: CGFloat) -> CGFloat {
		return RandomTools.randomCGFloat(min: min, max: max)
	}
}

/**
* Returns the shortest angle between two angles. The result is always between
* -π and π.
*/
public func shortestAngleBetween(angle1: CGFloat, angle2: CGFloat) -> CGFloat {
	let twoπ: CGFloat = pi * 2.0
	var angle: CGFloat = (angle2 - angle1) % twoπ
	if (angle >= pi) {
		angle = angle - twoπ
	}
	if (angle <= -pi) {
		angle = angle + twoπ
	}
	return angle
}

public func sign(value: CGFloat) -> CGFloat {
	if value >= 0.0 { return 1.0 }
	else { return -1.0 }
}
