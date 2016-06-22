import Foundation

import Quick
import Nimble

@testable
import DMTools

class ArrayPermutationsSpec: QuickSpec {
	override func spec() {
		describe("ArrayPerumations") {

			var sut: Array<Int>!

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
					expect(permutations).to(contain([1,2,3]))
				}

				it("should contain permutation 1,3,2") {
					expect(permutations).to(contain([1,3,2]))
				}

				it("should contain permutation 2,1,3") {
					expect(permutations).to(contain([2,1,3]))
				}

				it("should contain permutation 2,3,1") {
					expect(permutations).to(contain([2,3,1]))
				}

				it("should contain permutation 3,1,2") {
					expect(permutations).to(contain([3,1,2]))
				}

				it("should contain permutation 3,2,1") {
					expect(permutations).to(contain([3,2,1]))
				}
			}

			context("when array has two elements") {
				var permutations: [[Int]]!

				beforeEach {
					sut = [6,8]
					permutations = sut.generatePermutations()
				}

				afterEach {
					permutations = nil
				}

				it("should have two permutations") {
					expect(permutations.count).to(equal(2))
				}

				it("should have permutation 6,8") {
					expect(permutations).to(contain([6,8]))
				}

				it("should have permutation 8,6") {
					expect(permutations).to(contain([8,6]))
				}
			}

			context("when array has 6 elements") {
				beforeEach {
					sut = [1,2,3,4,5,6]
				}

				it("should contain a lot of elements") {
					expect(sut.generatePermutations().count).to(equal(1*2*3*4*5*6))
				}
			}
		}
	}
}