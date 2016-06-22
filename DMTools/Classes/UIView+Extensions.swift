//
//  UIView+Extensions.swift
//  DaftCode
//
//  Created by Patryk on 10/06/16.
//  Copyright © 2016 DaftMobile. All rights reserved.
//

import Foundation

public extension UIView {

	/**
	Adds the views to the end of the receiver’s list of subviews.
	This method establishes a strong reference to view and sets its next responder to the receiver, which is its new superview.
	Views can have only one superview. If view already has a superview and that view is not the receiver, this method removes the previous superview before making the receiver its new superview.

	- parameter subviews: The views to be added. After being added, the views appear on top of any other subviews and each other in order.
	*/

	public func addSubviews(subviews: [UIView]) {
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
	public func addSubviews(subviews: UIView ...) {
		for view in subviews {
			addSubview(view)
		}
	}


	/**
	Copies the data to a new `UIView`

	- returns: A copy of provided `UIView`
	*/
	public func viewCopy() -> UIView {
		return NSKeyedUnarchiver.unarchiveObjectWithData(NSKeyedArchiver.archivedDataWithRootObject(self).copy() as! NSData) as! UIView
	}
}
