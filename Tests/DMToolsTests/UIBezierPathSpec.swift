#if os(iOS)
//swiftlint:disable function_body_length
import Foundation
import UIKit
import Quick
import Nimble
@testable import DMTools

class UIBezierPathSpec: QuickSpec {
	override func spec() {
		describe("BezierPath") {

			var sourcePoints: [CGPoint]!

			var sut: UIBezierPath {
				return UIBezierPath.smoothBezierPathForPoints(sourcePoints)
			}

			afterEach {
				sourcePoints = nil
			}

			context("when source points is empty") {
				beforeEach {
					sourcePoints = []
				}

				it("should return empty bezier path") {
					expect(sut.isEmpty).to(beTrue())
				}
			}

			context("when source points has one element") {
				beforeEach {
					sourcePoints = [CGPoint(x: 1, y: 3)]
				}

				it("should not be empty") {
					expect(sut.isEmpty).to(beFalse())
				}

				it("should have just this one point") {
					expect(sut.currentPoint).to(equal(CGPoint(x: 1, y: 3)))
				}

				it("should contain point 1,3") {
					expect(sut.contains(CGPoint(x: 1, y: 3))).to(beTrue())
				}

				it("should contain moveto once") {
					expect(sut.description).to(contain("MoveTo"))
				}

				it("should not contain addLineTo") {
					expect(sut.description).notTo(contain("LineTo"))
				}
			}

			context("when source points has two elements") {
				let twoPoints: [CGPoint] = [(1.0, 10.0), (10.0, 1.0)].map { return CGPoint(x: $0.0, y: $0.1) }
				beforeEach {
					sourcePoints = twoPoints
				}

				it("should not be empty") {
					expect(sut.isEmpty).to(beFalse())
				}

				it("should contain two points") {
					expect(sut.contains(twoPoints[0])).to(beTrue())
					expect(sut.contains(twoPoints[1])).to(beTrue())
					expect(sut.contains(CGPoint(x: 0, y: 0))).to(beFalse())
				}

				it("should be at last point") {
					expect(sut.currentPoint).to(equal(twoPoints[1]))
				}

				it("should contain moveto once") {
					expect(sut.description).to(contain("MoveTo"))
				}

				it("should contain addLineTo") {
					expect(sut.description).to(contain("LineTo"))
				}
			}

			context("when source points has four points") {
				let fourPoints: [CGPoint] = [(0, 0), (10, 0), (10, 10), (0, 10)].map { return CGPoint(x: $0.0, y: $0.1) }

				beforeEach {
					sourcePoints = fourPoints
				}

				it("should not be empty") {
					expect(sut.isEmpty).to(beFalse())
				}

				it("should contain first point") {
					expect(sut.contains(fourPoints[0])).to(beTrue())
				}

				it("should contain last point") {
					expect(sut.contains(fourPoints[3])).to(beTrue())
				}

				it("should not contain middle points") {
					expect(sut.contains(fourPoints[1])).to(beFalse())
					expect(sut.contains(fourPoints[2])).to(beFalse())
				}

				it("should contain middle point between 0 and 1") {
					expect(sut.contains(CGPoint(x: 5, y: 0))).to(beTrue())
				}

				it("should contain middle point between 1 and 2") {
					expect(sut.contains(CGPoint(x: 10, y: 5))).to(beTrue())
				}

				it("should contain middle point between 2 and 3") {
					expect(sut.contains(CGPoint(x: 5, y: 10))).to(beTrue())
				}

				it("should be at last point") {
					expect(sut.currentPoint).to(equal(fourPoints[3]))
				}
			}
		}
	}
}

#endif
