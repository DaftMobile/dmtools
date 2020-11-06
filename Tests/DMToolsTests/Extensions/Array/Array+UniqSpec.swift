import Quick
import Nimble
@testable import DMTools

class Array_UniqSpec: QuickSpec {
	override func spec() {
		it("should remove duplicated from a simple array") {
			expect([1, 1, 1].uniq()).to(equal([1]))
		}

		it("should preserve the appearance order") {
			expect([1, 2, 1, 1].uniq()).to(equal([1, 2]))
		}

		it("should work with strings as well") {
			expect(["1", "2", "1", "x"].uniq()).to(equal(["1", "2", "x"]))
		}

		it("should work on empty array") {
			expect([Int]().uniq()).to(equal([Int]()))
		}

		it("should not remove anything if there are no duplicates") {
			expect([1, 2, 3].uniq()).to(equal([1, 2, 3]))
		}
	}
}
