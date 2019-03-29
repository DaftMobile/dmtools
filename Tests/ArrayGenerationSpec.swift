import Foundation
import Quick
import Nimble
@testable import DMTools

class ArrayGenerationSpec: QuickSpec {
	override func spec() {
		describe("ArrayGeneration") {
			describe("zeros") {
				it("should correctly generate 5 elements array") {
					let sut = 5.zeros()
					expect(sut.count).to(equal(5))
					expect(sut.max()).to(equal(0))
					expect(sut.min()).to(equal(0))
				}

				it("should correctly generate 20 elements array") {
					let sut = 20.zeros()
					expect(sut.count).to(equal(20))
					expect(sut.max()).to(equal(0))
					expect(sut.min()).to(equal(0))
				}

				it("should generate emtpy array when called on zero") {
					expect(0.zeros()).to(beEmpty())
				}
			}

			describe("naturals") {
				it("should correctly generate an array of 15 naturals") {
					let sut = 15.naturals()
					expect(sut.count).to(equal(15))
					expect(sut[0]).to(equal(0))
					expect(sut[5]).to(equal(5))
					expect(sut[14]).to(equal(14))
					expect(sut.last).to(equal(14))
				}

				it("should correctly generate an array of 3 naturals") {
					let sut = 3.naturals()
					expect(sut.count).to(equal(3))
					expect(sut[0]).to(equal(0))
					expect(sut[1]).to(equal(1))
					expect(sut[2]).to(equal(2))
				}

				it("should generate an empty array when called on zero") {
					expect(0.naturals()).to(beEmpty())
				}
			}
		}
	}
}
