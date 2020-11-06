import Foundation
import UIKit

@available(iOS 9.0, *)
public extension UIStackView {

	/**
	Adds the arranged subviews to the `UIStackView`.

	- parameter views: collection of views which should be added to the `UIStackView`
	*/
	func addArrangedSubviews(views: [UIView]) {
		views.forEach { addArrangedSubview($0) }
	}

	/**
	Removes all arrangedSubviews from the `UIStackView`.

	*/
	func removeAllArrangedSubviews() {
		arrangedSubviews.forEach {
			removeArrangedSubview($0)
			$0.removeFromSuperview()
		}
	}
}
