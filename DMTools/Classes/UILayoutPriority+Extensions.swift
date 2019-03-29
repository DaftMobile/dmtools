//
//  UILayoutPriority+Extensions.swift
//  DMTools
//
//  Created by Bartosz Kamiński on 07/02/2018.
//

import UIKit

public extension UILayoutPriority {

	/// Adds Float to UILayoutPriority raw value
	static func + (lhs: UILayoutPriority, rhs: Float) -> UILayoutPriority {
		return UILayoutPriority(lhs.rawValue + rhs)
	}

	/// Subtracts Float from UILayoutPriority raw value
	static func - (lhs: UILayoutPriority, rhs: Float) -> UILayoutPriority {
		return UILayoutPriority(lhs.rawValue - rhs)
	}
}
