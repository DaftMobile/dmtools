//
//  IntFactorialSpec.swift
//  DMTools
//
//  Copyright © 2016 DaftMobile. All rights reserved.
//

import Foundation

import Quick
import Nimble

@testable import DMTools

class IntFactorialSpec: QuickSpec {
	override func spec() {
		describe("IntFactorial") {
			it("should return 1 for input 0") {
				expect(0.factorial()).to(equal(1))
			}

			it("should return 1 for input 1") {
				expect(1.factorial()).to(equal(1))
			}

			it("should return 2 for input 2") {
				expect(2.factorial()).to(equal(2))
			}

			it("should return 6 for input 3") {
				expect(3.factorial()).to(equal(6))
			}

			it("should return 10! for input 10") {
				expect(10.factorial()).to(equal(3628800))
			}

			it("should return 7! for input 7") {
				expect(7.factorial()).to(equal(5040))
			}
		}
	}
}
