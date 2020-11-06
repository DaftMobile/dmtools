import Foundation
import Quick
import Nimble
@testable import DMTools

class LowPassFilterSignalSpec: QuickSpec {
	override func spec() {
		describe("LowPassFilterSignal") {
			it("should work normally with half filter") {
				var sut = LowPassFilterSignal<Double>(value: 0.0, filterFactor: 0.5)
				sut.update(newValue: 1.0)
				expect(sut.value).to(equal(0.5))
				sut.update(newValue: 1.0)
				expect(sut.value).to(equal(0.75))
			}

			it("should work normally with full filter") {
				var sut = LowPassFilterSignal<Double>(value: 0.0, filterFactor: 1.0)
				sut.update(newValue: 1.0)
				expect(sut.value).to(equal(0.0))
			}

			it("should work normally with no filter") {
				var sut = LowPassFilterSignal<Double>(value: 0.0, filterFactor: 0.0)
				sut.update(newValue: 1.0)
				expect(sut.value).to(equal(1.0))
			}

			it("should work normally with floats") {
				var sut = LowPassFilterSignal<Float>(value: 5.0, filterFactor: 0.1)
				sut.update(newValue: 0.0)
				expect(sut.value).to(equal(0.5))
			}
		}
	}
}
