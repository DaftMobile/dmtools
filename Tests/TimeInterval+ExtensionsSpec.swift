import Foundation
import Nimble
import Quick

class TimeInterval_Extensions: QuickSpec {
	override func spec() {
		describe("TimeInterval_Extensions") {
			var sut: TimeInterval!

			afterEach {
				sut = nil
			}

			describe("init") {
				describe("minutes") {
					beforeEach {
						sut = TimeInterval(minutes: 50)
					}

					it("should set correct interval in seconds") {
						expect(sut).to(equal(3000))
					}
				}

				describe("hours") {
					beforeEach {
						sut = TimeInterval(hours: 12)
					}

					it("should set correct interval in seconds") {
						expect(sut).to(equal(43200))
					}
				}

				describe("days") {
					beforeEach {
						sut = TimeInterval(days: 3)
					}

					it("should set correct interval in seconds") {
						expect(sut).to(equal(259200))
					}
				}
			}

			describe("properties") {
				describe("minutes") {
					beforeEach {
						sut = TimeInterval(3000)
					}

					it("should return correct minutes from time interval") {
						expect(sut.minutes).to(equal(50))
					}
				}

				describe("not full minutes") {
					beforeEach {
						sut = TimeInterval(1416) //23.6
					}

					it("should return correct minutes from time interval") {
						expect(sut.minutes).to(equal(23))
					}
				}

				describe("hours") {
					beforeEach {
						sut = TimeInterval(43200)
					}

					it("should return correct hours from time interval") {
						expect(sut.hours).to(equal(12))
					}
				}

				describe("not full hours") {
					beforeEach {
						sut = TimeInterval(36720) //10.2
					}

					it("should return correct hours from time interval") {
						expect(sut.hours).to(equal(10))
					}
				}

				describe("days") {
					beforeEach {
						sut = TimeInterval(259200)
					}

					it("should return correct days from time interval") {
						expect(sut.days).to(equal(3))
					}
				}

				describe("not full days") {
					beforeEach {
						sut = TimeInterval(293760) //3.4
					}

					it("should return correct days from time interval") {
						expect(sut.days).to(equal(3))
					}
				}
			}
		}
	}
}
