//
//  NSDate+Extensions.swift
//  DaftCode
//
//  Created by Patryk on 09/06/16.
//  Copyright © 2016 DaftMobile. All rights reserved.
//

import Foundation

extension NSDate: Comparable { }

// MARK: - Comparing dates

public func ==(lhs: NSDate, rhs: NSDate) -> Bool {
	return lhs === rhs || lhs.compare(rhs) == .OrderedSame
}

public func <(lhs: NSDate, rhs: NSDate) -> Bool {
	return lhs.compare(rhs) == .OrderedAscending
}

public func >(lhs: NSDate, rhs: NSDate) -> Bool {
	return lhs.compare(rhs) == .OrderedDescending
}
