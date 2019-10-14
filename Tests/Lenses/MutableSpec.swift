// swiftlint:disable file_length function_body_length type_body_length

import Foundation
import Quick
import Nimble
import DMTools

private struct SampleError: Error { }

private struct TestedStruct: Mutable, Equatable {
	var int: Int
	var string: String
}

private final class TestedClass: Mutable, Equatable {
	var int: Int
	var string: String
	var another: TestedClass?

	init(int: Int, string: String, another: TestedClass?) {
		self.int = int
		self.string = string
		self.another = another
	}

	static func ==(lhs: TestedClass, rhs: TestedClass) -> Bool {
		return lhs.int == rhs.int && lhs.string == rhs.string && (lhs.another === rhs.another || lhs.another == rhs.another)
	}
}

class MutableSpec: QuickSpec {
	override func spec() {
		describe("Mutable") {

			describe("struct") {
				var sut: TestedStruct!

				beforeEach {
					sut = TestedStruct(int: 15, string: "Struct")
				}

				it("should not mutate when not asked to") {
					expect(sut.mutate { _ in } ).to(equal(sut))
				}

				it("should be able to mutate one") {
					expect(sut.mutate { $0.string = "New" }).to(equal(.init(int: 15, string: "New")))
				}

				it("should rethrow when mutating one") {
					expect { try sut.mutate { _ in throw SampleError() } }.to(throwError(SampleError()))
				}

				it("should be able to mutate multiple") {
					let mutated = sut.mutate{
						$0.string = "New"
						$0.int = 22
					}
					expect(mutated).to(equal(.init(int: 22, string: "New")))
				}
			}

			describe("class") {
				var sut: TestedClass!

				beforeEach {
					sut = TestedClass(int: 15, string: "Class", another: TestedClass(int: 11, string: "nope", another: nil))
				}

				it("should not mutate when not asked to") {
					expect(sut.mutate { _ in } ).to(equal(sut))
				}

				it("should be able to mutate one") {
					expect(sut.mutate { $0.string = "New" }).to(equal(.init(int: 15, string: "New", another: sut.another)))
				}

				it("should be mutate the same instance mutating one") {
					expect(sut.mutate { $0.string = "New" }).to(be(sut))
				}

				it("should be able to mutate multiple") {
					let mutated = sut.mutate{
						$0.string = "New"
						$0.int = 22
					}
					expect(mutated).to(equal(.init(int: 22, string: "New", another: sut.another)))
				}

				it("should be mutate the same instance when mutating") {
					let mutated = sut.mutate{
						$0.string = "New"
						$0.int = 22
					}
					expect(mutated).to(be(sut))
				}

				it("should rethrow when mutating") {
					expect { try sut.mutate { _ in throw SampleError() } }.to(throwError(SampleError()))
				}
			}
		}
	}
}
