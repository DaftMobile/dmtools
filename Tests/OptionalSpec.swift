import Foundation
import Quick
import Nimble
@testable import DMTools

private struct TestError: Error {}

class OptionalSpec: QuickSpec {
	override func spec() {
		describe("Optional") {
			describe("Take") {
				it("should correctly take nil") {
					let value: Int? = nil
					expect(value.take { _ in }).to(beNil())
				}

				it("should not call closure when taking nil") {
					let value: Int? = nil
					value.take { _ in fail() }
				}

				it("should correctly take optional value") {
					let value: Int? = 1
					expect(value.take { $0 }).to(equal(1))
				}

				it("should be able to work with throwing functions") {
					let value: Int? = 1
					expect { try value.take({ value in
						if value > 0 { throw TestError() } else { return value }
						})
					}.to(throwError())
				}

				it("should not throw error in valid cases") {
					let value: Int? = 1
					expect { try value.take {
						if $0 > 10 { throw TestError() }
						return $0
					}
					}.notTo(throwError())
				}

				it("should correctly apply closure with different type") {
					let value: Int? = 4
					expect(value.take { $0 > 0 }).to(beTrue())
				}

				it("should correctly apply closure with the same type") {
					let value: Int? = 4
					expect(value.take { 10 * $0 }).to(equal(40))
				}
			}

			describe("unwrap") {

				let value: Int? = 4
				let vnil: Int? = nil

				it("should not throw if there is a value") {
					expect { try value.unwrap(or: TestError()) }.notTo(throwError())
				}

				it("should correctly unwrap optional integer") {
					expect(try? value.unwrap(or: TestError())).to(equal(4))
				}

				it("should throw error if there is nil") {
					expect { try vnil.unwrap(or: TestError()) }.to(throwError())
				}

				it("should throw correct error if there is nil") {
					expect { try vnil.unwrap(or: TestError()) }.to(throwError(errorType: TestError.self))
				}
			}
		}
	}
}
