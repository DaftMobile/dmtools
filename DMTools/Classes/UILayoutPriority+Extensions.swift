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
