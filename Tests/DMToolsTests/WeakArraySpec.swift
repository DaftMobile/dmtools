//swiftlint:disable function_body_length
import Foundation
import Quick
import Nimble
@testable import DMTools

class IntWrapper: Equatable, CustomDebugStringConvertible, CustomStringConvertible {
	let value: Int

	init(_ value: Int) {
		self.value = value
	}

	var debugDescription: String {
		return "\(value)"
	}

	var description: String {
		return value.description
	}
}

func == (lhs: IntWrapper, rhs: IntWrapper) -> Bool {
	return lhs.value == rhs.value
}

class WeakArraySpec: QuickSpec {
	override func spec() {
		describe("WeakArray") {

			var sut: WeakArray<IntWrapper>!

			var number: IntWrapper?

			beforeEach {
				sut = WeakArray<IntWrapper>()
				number = IntWrapper(32)
			}

			afterEach {
				sut = nil
			}

			it("should have count 0") {
				expect(sut.count).to(equal(0))
			}

			it("should be empty") {
				expect(sut.isEmpty).to(beTruthy())
			}

			it("should return nil for first") {
				expect(sut.first).to(beNil())
			}

			it("should return nil for last") {
				expect(sut.last).to(beNil())
			}

			context("when number is added") {
				beforeEach {
					sut.append(number)
				}

				it("should add element") {
					expect(sut[0]).to(equal(number))
				}

				it("should return element for first and last after adding element") {
					expect(sut.last).to(equal(number))
					expect(sut.first).to(equal(number))
				}

				it("should not be empty") {
					expect(sut.count).to(equal(1))
					expect(sut.isEmpty).to(beFalsy())
				}

				context("when element is unretained") {
					beforeEach {
						number = nil
					}

					it("should remove element that is unretained") {
						expect(sut[0]).to(beNil())
					}
				}

			}

			context("when four elements are added") {
				var value0: IntWrapper!
				var value1: IntWrapper!
				var value2: IntWrapper!
				var value3: IntWrapper!

				beforeEach {
					value0 = IntWrapper(0)
					value1 = IntWrapper(1)
					value2 = IntWrapper(2)
					value3 = IntWrapper(3)

					sut.append(value0)
					sut.append(value1)
					sut.append(value2)
					sut.append(value3)
				}

				afterEach {
					value0 = nil
					value1 = nil
					value2 = nil
					value3 = nil
				}

				it("should have four elements") {
					expect(sut.count).to(equal(4))
				}

				it("should hold other elements") {
					value1 = nil
					expect(sut[0]).to(equal(value0))
					expect(sut[1]).to(beNil())
					expect(sut[2]).to(equal(value2))
					expect(sut[3]).to(equal(value3))
				}

				it("should not change array after consolidating") {
					sut.consolidate()
					expect(sut[0]).to(equal(value0))
					expect(sut[1]).to(equal(value1))
					expect(sut[2]).to(equal(value2))
					expect(sut[3]).to(equal(value3))
				}

				it("should remove unretained values from array when asked") {
					value1 = nil
					value2 = nil
					sut.consolidate()
					expect(sut.count).to(equal(2))
					expect(sut[0]).to(equal(value0))
					expect(sut[1]).to(equal(value3))
				}

				it("should correctly insert at index") {
					let n10 = IntWrapper(10)
					sut.insert(n10, atIndex: 2)
					expect(sut.count).to(equal(5))
					expect(sut[0]).to(equal(value0))
					expect(sut[1]).to(equal(value1))
					expect(sut[2]).to(equal(n10))
					expect(sut[3]).to(equal(value2))
					expect(sut[4]).to(equal(value3))

				}

				it("should be able to print description") {
					expect(sut.description).to(equal("[0, 1, 2, 3]"))
				}

				it("should be able to iterate through the array") {
					var val = 0
					for element in sut {
						expect(element.value).to(equal(val))
						val += 1
					}
				}

				it("should not include dealocated element in generator") {
					value1 = nil
					value0 = nil
					var sum = 0
					var loopCounter = 0
					for element in sut {
						sum += element.value
						loopCounter += 1
					}
					expect(sum).to(equal(5))
					expect(loopCounter).to(equal(2))
				}

				it("should remove elements correctly") {
					_ = sut.removeAtIndex(1)
					expect(sut[0]).to(equal(value0))
					expect(sut[1]).to(equal(value2))
					expect(sut[2]).to(equal(value3))
				}

			}

		}
	}
}
