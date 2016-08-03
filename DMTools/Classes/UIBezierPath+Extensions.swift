//
//  UIBezierPath+Extensions.swift
//  DMTools
//
//  Created by Kajetan Dąbrowski on 03/08/16.
//	Copyright DaftMobile. All rights reserved.
//

import UIKit

extension UIBezierPath {
	
	/**
	Creates smooth Bezier Path guided by passed points. Smoothing the Bezier Path requires minimal number of 3 points.
	The path is guaranteed to contain the first point and the last points, but all the points in between will not be included in the actual path.
	Middle points are used as QuadCurve control points.
	For best results use long arrays (more than 10 points).
	
	- parameter points:	Array of points. Bezier path will start at points.first and end at points.last.
	
	- returns: Smooth Bezier Path
	*/
	public class func smoothBezierPathForPoints(points: [CGPoint]) -> UIBezierPath {
		let path = UIBezierPath()

		let midPoint: (CGPoint, CGPoint) -> CGPoint = {(p1, p2) -> CGPoint in
			//średnia arytmetyczna punktów to środek
			return CGPoint(x: 0.5*(p1.x + p2.x), y: 0.5*(p1.y + p2.y))
		}

		switch points.count {
		case 0:
			break
		case 1:
			path.moveToPoint(points[0])
		case 2:
			path.moveToPoint(points[0])
			path.addLineToPoint(points[1])
		default:
			path.moveToPoint(points[0])
			path.addLineToPoint(midPoint(points[0], points[1]))
			
			for i in 1..<points.count-1 {
				path.addQuadCurveToPoint(midPoint(points[i], points[i+1]), controlPoint: points[i])
			}
			
			path.addLineToPoint(points.last!)
		}
		return path
	}
}
