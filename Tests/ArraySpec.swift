//swiftlint:disable function_body_length
import Foundation
import Quick
import Nimble
@testable import DMTools

private class EquatableClass: Equatable {
	let value: Int
	init(value: Int) { self.value = value }
	static func == (lhs: EquatableClass, rhs: EquatableClass) -> Bool { return lhs.value == rhs.value }
}

private class NonEquatableClass {
	let value: Int
	init(value: Int) { self.value = value }
}

class ArrayExtensionsSpec: QuickSpec {
	override func spec() {
		describe("remove") {
			it("should correctly remove from ints") {
				var sut = [2, 3, 4]
				sut.remove(value: 3)
				expect(sut).to(equal([2, 4]))
			}

			it("should remove one when having two equal") {
				var sut = [2, 3, 5, 5]
				sut.remove(value: 5)
				expect(sut).to(equal([2, 3, 5]))
			}

			it("should remove the first equal copy") {
				var sut = [2, 3, 5, 1, 5]
				sut.remove(value: 5)
				expect(sut).to(equal([2, 3, 1, 5]))
			}

			it("should not remove when does not contain") {
				var sut = [2, 3, 5, 1, 5]
				sut.remove(value: 10)
				expect(sut).to(equal([2, 3, 5, 1, 5]))
			}

			it("should not remove when different type") {
				var sut = [2, 3, 5, 1, 5]
				sut.remove(value: 3.0)
				expect(sut).to(equal([2, 3, 5, 1, 5]))
			}

			it("should work with equatable objects") {
				var sut = [2, 3, 4].map { EquatableClass(value: $0) }
				sut.remove(value: EquatableClass(value: 4))
				expect(sut).to(equal([EquatableClass(value: 2), EquatableClass(value: 3)]))
			}

			it("should correctly remove from heterogenous array") {
				var sut: [Any] = [2, 4.0, EquatableClass(value: 10), NonEquatableClass(value: 2)]
				sut.remove(value: 4.0)
				expect(sut[0] as? Int == 2).to(beTrue())
				expect(sut[1] as? EquatableClass == EquatableClass(value: 10)).to(beTrue())
			}
		}

		describe("removing") {
			it("should correctly remove from ints") {
				expect([2, 3, 4].removing(value: 3)).to(equal([2, 4]))
			}

			it("should remove one when having two equal") {
				expect([2, 3, 5, 5].removing(value: 5)).to(equal([2, 3, 5]))
			}

			it("should remove the first equal copy") {
				expect([2, 3, 5, 1, 5].removing(value: 5)).to(equal([2, 3, 1, 5]))
			}

			it("should not remove when does not contain") {
				expect([2, 3, 5, 1, 5].removing(value: 10)).to(equal([2, 3, 5, 1, 5]))
			}

			it("should not remove when different type") {
				expect([2, 3, 5, 1, 5].removing(value: 3.0)).to(equal([2, 3, 5, 1, 5]))
			}

			it("should work with equatable objects") {
				let sut = [2, 3, 4].map { EquatableClass(value: $0) }.removing(value: EquatableClass(value: 4))
				expect(sut).to(equal([EquatableClass(value: 2), EquatableClass(value: 3)]))
			}
		}
	}
}
