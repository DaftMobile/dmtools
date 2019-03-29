import UIKit

public extension UIBezierPath {

	/**
	Creates smooth Bezier Path guided by passed points. Smoothing the Bezier Path requires minimal number of 3 points.
	The path is guaranteed to contain the first point and the last points, but all the points in between will not be included in the actual path.
	Middle points are used as QuadCurve control points.
	For best results use long arrays (more than 10 points).

	- parameter points:	Array of points. Bezier path will start at points.first and end at points.last.
	- returns: Smooth Bezier Path
	*/
	class func smoothBezierPathForPoints(_ points: [CGPoint]) -> UIBezierPath {
		let path = UIBezierPath()

		let midPoint: (CGPoint, CGPoint) -> CGPoint = { point1, point2 -> CGPoint in
			//średnia arytmetyczna punktów to środek
			return CGPoint(x: 0.5 * (point1.x + point2.x), y: 0.5 * (point1.y + point2.y))
		}

		switch points.count {
		case 0:
			break
		case 1:
			path.move(to: points[0])
		case 2:
			path.move(to: points[0])
			path.addLine(to: points[1])
		default:
			path.move(to: points[0])
			path.addLine(to: midPoint(points[0], points[1]))

			for index in 1..<points.count - 1 {
				path.addQuadCurve(to: midPoint(points[index], points[index + 1]), controlPoint: points[index])
			}

			path.addLine(to: points.last!)
		}
		return path
	}
}
