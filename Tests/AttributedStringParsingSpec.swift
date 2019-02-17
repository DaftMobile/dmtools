//swiftlint:disable function_body_length
import Foundation
import UIKit
import Quick
import Nimble
@testable import DMTools

class AttributedStringParsingSpec: QuickSpec {
	override func spec() {
		describe("AttributedStringParsing") {

			let baseFont = UIFont.systemFont(ofSize: 14)
			let baseAttributes: [NSAttributedString.Key: Any] = [
				NSAttributedString.Key.font: baseFont,
				NSAttributedString.Key.foregroundColor: UIColor.white
			]

			var sut: NSAttributedString!

			afterEach {
				sut = nil
			}

			context("when there are no special marks") {

				beforeEach {
					let startString = "This is a string"
					sut = NSAttributedString.parse(startString, attributes: baseAttributes, separatorSymbols: [])

				}

				it("have the same string inside") {
					expect(sut.string).to(equal("This is a string"))
				}

				it("should have correct font") {
					for index in 0..<sut.length {
						expect(sut.attribute(NSAttributedString.Key.font, at: index, effectiveRange: nil) as? UIFont).to(equal(baseFont))
					}
				}

				it("should have correct color") {
					for index in 0..<sut.length {
						expect(sut.attribute(NSAttributedString.Key.foregroundColor, at: index, effectiveRange: nil) as? UIColor).to(equal(UIColor.white))
					}
				}
			}

			context("when there are two special marks") {

				let specialMark: String = "^"
				let additionalAttributes: [NSAttributedString.Key: Any] = [
					NSAttributedString.Key.foregroundColor: UIColor.yellow
				]

				beforeEach {
					let startString = "This ^is a^ string"
					sut = NSAttributedString.parse(startString, attributes: baseAttributes, separatorSymbols: [specialMark], additionalAttributes: additionalAttributes)
				}

				it("have the same string inside") {
					expect(sut.string).to(equal("This is a string"))
				}

				it("should have correct font") {
					for index in 0..<sut.length {
						expect(sut.attribute(NSAttributedString.Key.font, at: index, effectiveRange: nil) as? UIFont).to(equal(baseFont))
					}
				}

				it("should have correct color") {
					for index in 0..<5 {
						expect(sut.attribute(NSAttributedString.Key.foregroundColor, at: index, effectiveRange: nil) as? UIColor).to(equal(UIColor.white))
					}
					for index in 5..<9 {
						expect(sut.attribute(NSAttributedString.Key.foregroundColor, at: index, effectiveRange: nil) as? UIColor).to(equal(UIColor.yellow))
					}

					for index in 9..<sut.length {
						expect(sut.attribute(NSAttributedString.Key.foregroundColor, at: index, effectiveRange: nil) as? UIColor).to(equal(UIColor.white))
					}
				}
			}

			context("when creating a bold string") {
				let boldFont = UIFont.boldSystemFont(ofSize: 14)

				beforeEach {
					let startString = "<b>This<b> is a string and <b>this<b> should be <b>bolo<b>."
					sut = NSAttributedString.parse(startString, attributes: baseAttributes, separatorSymbols: ["<b>"], additionalAttributes: [NSAttributedString.Key.font: boldFont])
				}

				it("have the same string inside") {
					expect(sut.string).to(equal("This is a string and this should be bolo."))
				}

				it("should have correct fonts") {
					let bolds = [0...3, 21...24, 36...39]
					let normals = [4...20, 25...35, 40...40]
					bolds.forEach({ range in
						for index in range {
							expect(sut.attribute(NSAttributedString.Key.font, at: index, effectiveRange: nil) as? UIFont).to(equal(boldFont))
						}
					})

					normals.forEach({ range in
						for index in range {
							expect(sut.attribute(NSAttributedString.Key.font, at: index, effectiveRange: nil) as? UIFont).to(equal(baseFont))
						}
					})
				}
			}

			context("when there are two different attributes") {

				beforeEach {
					let startString = "<red>0<red><blue>1<blue>"
					sut = NSAttributedString.parse(startString, attributes: [:], separatorsAndAttributesInside: ["<red>": [NSAttributedString.Key.foregroundColor: UIColor.red], "<blue>": [NSAttributedString.Key.foregroundColor: UIColor.blue]])
				}

				it("have the same string inside") {
					expect(sut.string).to(equal("01"))
				}

				it("should have correct attributes for 0") {
					let attributes = sut.attributes(at: 0, effectiveRange: nil)
					expect(attributes[NSAttributedString.Key.foregroundColor] as? UIColor).to(equal(UIColor.red))
				}

				it("should have correct attributes for 1") {
					let attributes = sut.attributes(at: 1, effectiveRange: nil)
					expect(attributes[NSAttributedString.Key.foregroundColor] as? UIColor).to(equal(UIColor.blue))
				}

			}

			context("when there are three different attributes") {
				let boldFont = UIFont.boldSystemFont(ofSize: 14)

				beforeEach {
					let startString = "<red>0<red><blue>1<blue><green>2<green><red>3<red><bold>4<bold>"
					sut = NSAttributedString.parse(startString, attributes: baseAttributes, separatorsAndAttributesInside: ["<red>": [NSAttributedString.Key.foregroundColor: UIColor.red], "<blue>": [NSAttributedString.Key.foregroundColor: UIColor.blue], "<green>": [NSAttributedString.Key.foregroundColor: UIColor.green], "<bold>": [NSAttributedString.Key.font: boldFont]])
				}

				it("have the same string inside") {
					expect(sut.string).to(equal("01234"))
				}

				it("should have correct attributes for 0") {
					let attributes = sut.attributes(at: 0, effectiveRange: nil)
					expect(attributes[NSAttributedString.Key.font] as? UIFont).to(equal(baseFont))
					expect(attributes[NSAttributedString.Key.foregroundColor] as? UIColor).to(equal(UIColor.red))
				}

				it("should have correct attributes for 1") {
					let attributes = sut.attributes(at: 1, effectiveRange: nil)
					expect(attributes[NSAttributedString.Key.font] as? UIFont).to(equal(baseFont))
					expect(attributes[NSAttributedString.Key.foregroundColor] as? UIColor).to(equal(UIColor.blue))
				}

				it("should have correct attributes for 2") {
					let attributes = sut.attributes(at: 2, effectiveRange: nil)
					expect(attributes[NSAttributedString.Key.font] as? UIFont).to(equal(baseFont))
					expect(attributes[NSAttributedString.Key.foregroundColor] as? UIColor).to(equal(UIColor.green))
				}

				it("should have correct attributes for 3") {
					let attributes = sut.attributes(at: 3, effectiveRange: nil)
					expect(attributes[NSAttributedString.Key.font] as? UIFont).to(equal(baseFont))
					expect(attributes[NSAttributedString.Key.foregroundColor] as? UIColor).to(equal(UIColor.red))
				}

				it("should have correct attributes for 4") {
					let attributes = sut.attributes(at: 4, effectiveRange: nil)
					expect(attributes[NSAttributedString.Key.font] as? UIFont).to(equal(boldFont))
					expect(attributes[NSAttributedString.Key.foregroundColor] as? UIColor).to(equal(UIColor.white))
				}
			}
		}
	}
}
