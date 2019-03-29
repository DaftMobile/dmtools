//
//  Created by DaftMobile Sp z o. o.
//  Copyright (c) 2015 DaftMobile. All rights reserved.
//

import Foundation

public extension Optional {

	/// Take a value and map it with block that takes unwrapped value, or just return nil. Very useful for oneliners instead of if let magic.
	///
	/// - Parameter closure: closure to map a wrapped value
	/// - Returns: mapped value or nil
	/// - Throws: rethrows if closure throws
    func take<U>(_ closure: (Wrapped) throws -> U) rethrows -> U? {
		switch self {
		case .some(let wrapped): return try closure(wrapped)
		case .none: return nil
		}
	}

	/// Unwrap or throw passed error. Very useful to avoid force unwrapping
	///
	/// - Parameter error: error that will be thrown iff value is nil
	/// - Returns: wrapped value
	/// - Throws: passed error, if optional contains nil
    func unwrap(or error: Error) throws -> Wrapped {
		switch self {
		case .some(let wrapped): return wrapped
		case .none: throw error
		}
	}
}
