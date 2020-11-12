import Foundation
import Quick
import Nimble
import UIKit

@testable import DMTools

class ColorParsingSpec: QuickSpec {
	override func spec() {
		describe("Color Parsing") {
			var sut: UIColor!

			var colors: [CGFloat] {
				var red: CGFloat = 0
				var green: CGFloat = 0
				var blue: CGFloat = 0
				var alpha: CGFloat = 0
				sut.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
				return [red, green, blue, alpha]
			}

			var red: CGFloat {
				return colors[0]
			}

			var green: CGFloat {
				return colors[1]
			}

			var blue: CGFloat {
				return colors[2]
			}

			var alpha: CGFloat {
				return colors[3]
			}

			afterEach {
				sut = nil
			}

			it("should correctly parse red color") {
				sut = UIColor(rgba: "#ff0000")
				expect(colors).to(equal([1.0, 0.0, 0.0, 1.0]))
			}

			it("should correctly parse green color") {
				sut = UIColor(rgba: "#00ff00")
				expect(colors).to(equal([0.0, 1.0, 0.0, 1.0]))
			}

			it("should correctly parse blue color") {
				sut = UIColor(rgba: "#0000ff")
				expect(colors).to(equal([0.0, 0.0, 1.0, 1.0]))
			}

			it("should correctly parse grey color") {
				sut = UIColor(rgba: "#808080")
				expect(red).to(beCloseTo(0.5, within: 0.02))
				expect(green).to(beCloseTo(0.5, within: 0.02))
				expect(blue).to(beCloseTo(0.5, within: 0.02))
				expect(alpha).to(equal(1.0))
			}
		}
	}
}
