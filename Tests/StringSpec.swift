import Foundation
import Quick
import Nimble

@testable import DMTools

class StringExtensionSpec: QuickSpec {
	override func spec() {
		describe("String Extension") {

			context("when localizing a string with two integer variables") {

				let startFormat = "Your score: %d out of %d"

				it("should localize in English correctly") {
					expect(startFormat.localizeWithFormat(arguments: 10, 30)).to(equal("Your score: 10 out of 30"))
					expect(startFormat.localizeWithFormat(arguments: 10, 30, reverse: false)).to(equal("Your score: 10 out of 30"))
				}

				it("should correctly reverse in Japanese") {
					expect(startFormat.localizeWithFormat(arguments: 10, 30, reverse: true)).to(equal("Your score: 30 out of 10"))
				}
			}

		}

		describe("removeWhiteSpaces") {
			var sut: String!

			afterEach {
				sut = nil
			}

			describe("string with white spaces") {
				beforeEach {
					sut = "Ala ma   kota"
				}

				it("should return string witout white spaces") {
					expect(sut.removeWhiteSpaces()).to(equal("Alamakota"))
				}
			}

			describe("string without white spaces") {
				beforeEach {
					sut = "~BllalarbtbvfdfHDefrfko"
				}

				it("should not change string") {
					expect(sut.removeWhiteSpaces()).to(equal("~BllalarbtbvfdfHDefrfko"))
				}
			}
		}

		describe("capitalizedFirstLetter") {
			var sut: String!

			afterEach {
				sut = nil
			}

			describe("string where every word has lowercased letters") {
				beforeEach {
					sut = "one, two, three"
				}

				it("should return string with capitalized first letter in first word") {
					expect(sut.capitalizedFirstLetter()).to(equal("One, two, three"))
				}
			}

			describe("string with every word capitalized") {
				beforeEach {
					sut = "One, Two, Three"
				}

				it("should return string with capitalized first letter in first word") {
					expect(sut.capitalizedFirstLetter()).to(equal("One, two, three"))
				}
			}

			describe("string with lowercased letters") {
				beforeEach {
					sut = "alamakota"
				}

				it("should return string with capitalized first letter in first word") {
					expect(sut.capitalizedFirstLetter()).to(equal("Alamakota"))
				}
			}

			describe("capitalized string") {
				beforeEach {
					sut = "Alamakota"
				}

				it("should return string with capitalized first letter in first word") {
					expect(sut.capitalizedFirstLetter()).to(equal("Alamakota"))
				}
			}

			describe("string with first word capitalized") {
				beforeEach {
					sut = "One, two, three"
				}

				it("should return string with capitalized first letter in first word") {
					expect(sut.capitalizedFirstLetter()).to(equal("One, two, three"))
				}
			}

			describe("string upercased letters in the middle") {
				beforeEach {
					sut = "alaMaKota"
				}

				it("should return string with capitalized first letter in first word") {
					expect(sut.capitalizedFirstLetter()).to(equal("Alamakota"))
				}
			}
		}
	}
}
