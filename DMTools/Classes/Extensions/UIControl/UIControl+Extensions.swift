import Foundation
import UIKit

public extension UIControl {

	/**
	Counts hit area that always complies with Apple Human Interface Guidelines by having at least 44x44 size

	- returns: `CGRect` for tap area
	*/
	func tappableArea() -> CGRect {
		let minimumHitArea: CGSize = CGSize(width: 44, height: 44)
		let widthToAdd = max(minimumHitArea.width - bounds.size.width, 0)
		let heightToAdd = max(minimumHitArea.height - bounds.size.height, 0)
		let enlargedArea = bounds.insetBy(dx: -widthToAdd / 2, dy: -heightToAdd / 2)
		return enlargedArea
	}
	
}
