import Nimble
import Quick
import UIKit
@testable import DMTools

@available(iOS 9.0, *)
class UIStackView_ExtensionSpec: QuickSpec {
	override func spec() {
		describe("UIStackView+Extensions") {
			var sut: UIStackView!
			var views: [UIView]!

			beforeEach {
				sut = UIStackView()
				views = [UILabel(), UIView(), UIImageView()]
			}

			afterEach {
				sut = nil
				views = nil
			}

			context("when addArrangedSubviews called") {
				beforeEach {
					sut.addArrangedSubviews(views: views)
				}

				it("should set correct views in arranged subviews of stack view") {
					expect(sut.arrangedSubviews).to(equal(views))
				}

				context("when removeArrangedSubviews called") {
					beforeEach {
						sut.removeAllArrangedSubviews()
					}

					it("should be empty array of arranged subviews") {
						expect(sut.arrangedSubviews).to(beEmpty())
					}
				}
			}
		}
	}
}
