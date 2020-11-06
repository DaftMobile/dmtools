//swiftlint:disable function_body_length
import Foundation
import Quick
import Nimble
@testable import DMTools

class ArrayPermutationsSpec: QuickSpec {
	override func spec() {
		describe("ArrayPerumations") {

			var sut: [Int]!

			afterEach {
				sut = nil
			}

			context("when array is empty") {
				beforeEach {
					sut = []
				}

				it("should return empty permutations array for an empty array") {
					expect(sut.generatePermutations()).to(beEmpty())
				}
			}

			context("when array has one element") {
				beforeEach {
					sut = [15]
				}

				it("should have one permutation") {
					expect(sut.generatePermutations().count).to(equal(1))
				}

				it("should have one element") {
					expect(sut.generatePermutations().first).to(equal([15]))
				}
			}

			context("when array has three elements") {
				var permutations: [[Int]]!

				beforeEach {
					sut = [1, 2, 3]
					permutations = sut.generatePermutations()
				}

				afterEach {
					permutations = nil
				}

				it("should have six permutations") {
					expect(sut.generatePermutations().count).to(equal(6))
				}

				it("should contain permutation 1,2,3") {
					expect(permutations.contains(where: { $0 == [1, 2, 3] })).to(beTrue())
				}

				it("should contain permutation 1,3,2") {
					expect(permutations.contains(where: { $0 == [1, 3, 2] })).to(beTrue())
				}

				it("should contain permutation 2,1,3") {
					expect(permutations.contains(where: { $0 == [2, 1, 3] })).to(beTrue())
				}

				it("should contain permutation 2,3,1") {
					expect(permutations.contains(where: { $0 == [2, 3, 1] })).to(beTrue())
				}

				it("should contain permutation 3,1,2") {
					expect(permutations.contains(where: { $0 == [3, 1, 2] })).to(beTrue())
				}

				it("should contain permutation 3,2,1") {
					expect(permutations.contains(where: { $0 == [3, 2, 1] })).to(beTrue())
				}
			}

			context("when array has two elements") {
				var permutations: [[Int]]!

				beforeEach {
					sut = [6, 8]
					permutations = sut.generatePermutations()
				}

				afterEach {
					permutations = nil
				}

				it("should have two permutations") {
					expect(permutations.count).to(equal(2))
				}

				it("should have permutation 6,8") {
					expect(permutations.contains(where: { $0 == [6, 8] })).to(beTrue())
				}

				it("should have permutation 8,6") {
					expect(permutations.contains(where: { $0 == [8, 6] })).to(beTrue())
				}
			}

			context("when array has 6 elements") {
				beforeEach {
					sut = [1, 2, 3, 4, 5, 6]
				}

				it("should contain a lot of elements") {
					expect(sut.generatePermutations().count).to(equal(6.factorial()))
				}
			}
		}
	}
}
