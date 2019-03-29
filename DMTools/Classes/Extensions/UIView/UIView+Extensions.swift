//
//  Created by DaftMobile Sp z o. o.
//  Copyright (c) 2015 DaftMobile. All rights reserved.
//

import Foundation

public extension UIView {

	/**
	Adds the views to the end of the receiver’s list of subviews.
	This method establishes a strong reference to view and sets its next responder to the receiver, which is its new superview.
	Views can have only one superview. If view already has a superview and that view is not the receiver, this method removes the previous superview before making the receiver its new superview.

	- parameter subviews: The views to be added. After being added, the views appear on top of any other subviews and each other in order.
	*/
	@available(*, deprecated, message: "don't use the array version as it slows compile times")
    func addSubviews(_ subviews: [UIView]) {
		for view in subviews {
			addSubview(view)
		}
	}

	/**
	Adds the views to the end of the receiver’s list of subviews.
	This method establishes a strong reference to view and sets its next responder to the receiver, which is its new superview.
	Views can have only one superview. If view already has a superview and that view is not the receiver, this method removes the previous superview before making the receiver its new superview.

	- parameter subviews: The views to be added. After being added, the views appear on top of any other subviews and each other in order.
	*/
    func addSubviews(_ subviews: UIView ...) {
		for view in subviews {
			addSubview(view)
		}
	}

	/**
	Copies the data to a new `UIView`

	- returns: A copy of provided `UIView`
	*/
    func viewCopy() -> UIView {
		let archivedView = NSKeyedArchiver.archivedData(withRootObject: self)
		guard let newView = NSKeyedUnarchiver.unarchiveObject(with: archivedView) as? UIView else {
			fatalError("Could not unarchive view")
		}
		return newView
	}

	/**
	Adds shake animation to the receiver
	
	- parameter offset:		shake animation max offset. default value 15.0
	- parameter duration:	entire duration of the animation. Use 0.5 for best effect
	*/
	fileprivate func shake(offset: CGFloat = 15.0, duration: CFTimeInterval = 0.5) {
		let shakeOffsets: [CGFloat] = [-1, 1, -1, 1, -0.5, 0.5, -0.25, 0.25, 0]
		let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
		animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
		animation.duration = duration
		animation.values = shakeOffsets.map { offset * $0 }
		animation.isRemovedOnCompletion = true
		layer.removeAnimation(forKey: "shake")
		layer.add(animation, forKey: "shake")
	}
}
