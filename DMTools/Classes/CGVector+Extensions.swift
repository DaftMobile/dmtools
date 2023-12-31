//swiftlint:disable identifier_name
import CoreGraphics

public extension CGVector {
	/**
	* Creates a new CGVector given a CGPoint.
	*/
	init(point: CGPoint) {
		self.init(dx: point.x, dy: point.y)
	}

	/**
	* Given an angle in radians, creates a vector of length 1.0 and returns the
	* result as a new CGVector. An angle of 0 is assumed to point to the right.
	*/
	init(angle: CGFloat) {
		self.init(dx: cos(angle), dy: sin(angle))
	}

	/**
	* Adds (dx, dy) to the vector.
	*/
	mutating func offset(dx: CGFloat, dy: CGFloat) -> CGVector {
		self.dx += dx
		self.dy += dy
		return self
	}

	/**
	* Returns the length (magnitude) of the vector described by the CGVector.
	*/
	func length() -> CGFloat {
		return sqrt(dx * dx + dy * dy)
	}

	/**
	* Returns the squared length of the vector described by the CGVector.
	*/
	func lengthSquared() -> CGFloat {
		return dx * dx + dy * dy
	}

	/**
	* Normalizes the vector described by the CGVector to length 1.0 and returns
	* the result as a new CGVector.
	*/
	func normalized() -> CGVector {
		let len: CGFloat = length()
		return len > 0 ? self / len : CGVector.zero
	}

	/**
	* Normalizes the vector described by the CGVector to length 1.0.
	*/
	mutating func normalize() -> CGVector {
		self = normalized()
		return self
	}

	/**
	* Calculates the distance between two CGVectors. Pythagoras!
	*/
	func distanceTo(_ vector: CGVector) -> CGFloat {
		return (self - vector).length()
	}

	/**
	* Returns the angle in radians of the vector described by the CGVector.
	* The range of the angle is -π to π; an angle of 0 points to the right.
	*/
	var angle: CGFloat {
		return atan2(dy, dx)
	}

	var isZero: Bool {
		return self.dx.isZero && self.dy.isZero
	}
}

//swiftlint:disable shorthand_operator

/**
* Adds two CGVector values and returns the result as a new CGVector.
*/
public func + (left: CGVector, right: CGVector) -> CGVector {
	return CGVector(dx: left.dx + right.dx, dy: left.dy + right.dy)
}

/**
* Increments a CGVector with the value of another.
*/
public func += (left: inout CGVector, right: CGVector) {
	left = left + right
}

/**
* Subtracts two CGVector values and returns the result as a new CGVector.
*/
public func - (left: CGVector, right: CGVector) -> CGVector {
	return CGVector(dx: left.dx - right.dx, dy: left.dy - right.dy)
}

/**
* Decrements a CGVector with the value of another.
*/
public func -= (left: inout CGVector, right: CGVector) {
	left = left - right
}

/**
* Multiplies two CGVector values and returns the result as a new CGVector.
*/
public func * (left: CGVector, right: CGVector) -> CGVector {
	return CGVector(dx: left.dx * right.dx, dy: left.dy * right.dy)
}

/**
* Multiplies a CGVector with another.
*/
public func *= (left: inout CGVector, right: CGVector) {
	left = left * right
}

/**
* Multiplies the x and y fields of a CGVector with the same scalar value and
* returns the result as a new CGVector.
*/
public func * (vector: CGVector, scalar: CGFloat) -> CGVector {
	return CGVector(dx: vector.dx * scalar, dy: vector.dy * scalar)
}

/**
* Multiplies the x and y fields of a CGVector with the same scalar value.
*/
public func *= (vector: inout CGVector, scalar: CGFloat) {
	vector = vector * scalar
}

/**
* Divides two CGVector values and returns the result as a new CGVector.
*/
public func / (left: CGVector, right: CGVector) -> CGVector {
	return CGVector(dx: left.dx / right.dx, dy: left.dy / right.dy)
}

/**
* Divides a CGVector by another.
*/
public func /= (left: inout CGVector, right: CGVector) {
	left = left / right
}

/**
* Divides the dx and dy fields of a CGVector by the same scalar value and
* returns the result as a new CGVector.
*/
public func / (vector: CGVector, scalar: CGFloat) -> CGVector {
	return CGVector(dx: vector.dx / scalar, dy: vector.dy / scalar)
}

/**
* Divides the dx and dy fields of a CGVector by the same scalar value.
*/
public func /= (vector: inout CGVector, scalar: CGFloat) {
	vector = vector / scalar
}

/**
* Performs a linear interpolation between two CGVector values.
*/
public func lerp(start: CGVector, end: CGVector, percentage: CGFloat) -> CGVector {
	return start + (end - start) * percentage
}

//swiftlint:enable shorthand_operator

/**
* Performs a linear interpolation between two CGVector values.
*/

public func lerp(start: CGVector, end: CGVector, t: CGFloat) -> CGVector {
	return lerp(start: start, end: end, percentage: t)
}

/**
* Inverts the vector
*/
public prefix func - (right: CGVector) -> CGVector {
	return right * -1.0
}

public func CGVectorMake(angle: CGFloat, length: CGFloat) -> CGVector {
	return CGVector(dx: length * cos(angle), dy: length * sin(angle))
}

extension CGVector: CustomStringConvertible {
	public var description: String {
		return "[\(self.dx) , \(self.dy)]"
	}
}
