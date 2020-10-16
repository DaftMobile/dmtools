import Foundation
import UIKit

/// Provides a button that always complies with Apple Human Interface Guidelines by having hit area of at least 44x44
open class HIGButton: UIButton {

	// MARK: - Public API

	override open func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
		return tappableArea().contains(point)
	}
}
