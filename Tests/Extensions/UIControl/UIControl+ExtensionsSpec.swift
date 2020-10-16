import Nimble
import Quick
import UIKit
@testable import DMTools

class UIControl_ExtensionSpec: QuickSpec {
	override func spec() {
		describe("UIControl+Extension") {
			var sut: UIControl!
			var tappableArea: CGRect!

			afterEach {
				sut = nil
				tappableArea = nil
			}

			describe("width and height > 44") {
				beforeEach {
					sut = UIControl(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
					tappableArea = sut.tappableArea()
				}

				it("should be correct tappable area") {
					expect(tappableArea).to(equal(CGRect(x: 0, y: 0, width: 50, height: 50)))
				}
			}

			describe("width and height == 44") {
				beforeEach {
					sut = UIControl(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
					tappableArea = sut.tappableArea()
				}

				it("should be correct tappable area") {
					expect(tappableArea).to(equal(CGRect(x: 0, y: 0, width: 44, height: 44)))
				}
			}

			describe("width and height < 44") {
				beforeEach {
					sut = UIControl(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
					tappableArea = sut.tappableArea()
				}

				it("should be correct tappable area") {
					expect(tappableArea).to(equal(CGRect(x: -2, y: -7, width: 44, height: 44)))
				}
			}

			describe("width > 44 height < 44") {
				beforeEach {
					sut = UIControl(frame: CGRect(x: 0, y: 0, width: 80, height: 24))
					tappableArea = sut.tappableArea()
				}

				it("should be correct tappable area") {
					expect(tappableArea).to(equal(CGRect(x: 0, y: -10, width: 80, height: 44)))
				}
			}

			describe("width < 44 height > 44") {
				beforeEach {
					sut = UIControl(frame: CGRect(x: 0, y: 0, width: 23, height: 45))
					tappableArea = sut.tappableArea()
				}

				it("should be correct tappable area") {
					expect(tappableArea).to(equal(CGRect(x: -10.5, y: 0, width: 44, height: 45)))
				}
			}
		}
	}
	
}
