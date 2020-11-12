import Nimble
import Quick
import UIKit
import DMTools

class UIView_ExtensionSpec: QuickSpec {

	override func spec() {
		describe("UIView+Extensions") {
			describe("copy") {
				var sut: UIView!

				beforeEach {
					sut = UIView(frame: CGRect(origin: .zero, size: .init(width: 100, height: 100)))
				}

				afterEach {
					sut = nil
				}

				it("should correctly copy a view") {
					expect { _ = sut.viewCopy() }.notTo(throwError())
				}

				it("should have the same frame") {
					expect(sut.viewCopy().frame).to(equal(CGRect(origin: .zero, size: .init(width: 100, height: 100))))
				}

				it("should not copy subviews when there arent any") {
					expect(sut.viewCopy().subviews).to(beEmpty())
				}

				it("should also copy subviews") {
					sut.addSubview(UIView(frame: .zero))
					expect(sut.viewCopy().subviews).to(haveCount(1))
				}
			}

			describe("add subviews") {
				it("should correctly add subviews") {
					let sut = UIView()
					sut.addSubviews(UIView(), UIView())
					expect(sut.subviews).to(haveCount(2))
				}
			}
		}
	}
}
