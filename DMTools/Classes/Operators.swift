//
//  Operators.swift
//  FingerHero
//
//  Created by Kajetan Dąbrowski on 19.05.2015.
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
