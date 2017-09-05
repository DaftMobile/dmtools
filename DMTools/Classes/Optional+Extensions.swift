//
//  Created by DaftMobile Sp z o. o.
//  Copyright (c) 2015 DaftMobile. All rights reserved.
//

import Foundation

public extension Optional {

	public func take<U>(_ closure: (Wrapped) throws -> U) rethrows -> U? {
		switch self {
		case .some(let wrapped): return try closure(wrapped)
		case .none: return nil
		}
	}

}
