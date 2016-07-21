//
//  Created by DaftMobile Sp z o. o.
//  Copyright (c) 2015 DaftMobile. All rights reserved.
//

import Foundation
import CoreGraphics

// MARK: CGFloat

public func / (lhs: CGFloat, rhs: Int) -> CGFloat {
	return lhs / CGFloat(rhs)
}

public func * (lhs: CGFloat, rhs: Int) -> CGFloat {
	return lhs * CGFloat(rhs)
}

public func + (lhs: CGFloat, rhs: Int) -> CGFloat {
	return lhs + CGFloat(rhs)
}

public func - (lhs: CGFloat, rhs: Int) -> CGFloat {
	return lhs - CGFloat(rhs)
}

// MARK: NSTimeInterval

public func / (lhs: NSTimeInterval, rhs: Int) -> NSTimeInterval {
	return NSTimeInterval(Double(lhs) / Double(rhs))
}

public func * (lhs: NSTimeInterval, rhs: Int) -> NSTimeInterval {
	return NSTimeInterval(Double(lhs) * Double(rhs))
}

public func / (lhs: NSTimeInterval, rhs: CGFloat) -> NSTimeInterval {
	return NSTimeInterval(Double(lhs) / Double(rhs))
}

public func * (lhs: NSTimeInterval, rhs: CGFloat) -> NSTimeInterval {
	return NSTimeInterval(Double(lhs) * Double(rhs))
}

//MARK: Exponentiation

infix operator ** {
associativity left
precedence 160
}

/**
Exponentiation operator

- parameter lhs:	base
- parameter rhs:	exponent

- returns: lhs to the power of rhs
*/
public func ** (lhs: UInt, rhs: UInt) -> UInt {
	return Array(count: Int(rhs), repeatedValue: lhs).reduce(1, combine: *)
}

