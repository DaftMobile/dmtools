//
//  SequenceSpec.swift
//  DMTools
//
//  Created by Kajetan Dąbrowski on 05/09/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation

import Quick
import Nimble

@testable
import DMTools

fileprivate struct TestError: Error {}

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
					value.take { _ in XCTFail() }
				}

				it("should should correctly take optional value") {
					let value: Int? = 1
					expect(value.take { $0 }).to(equal(1))
				}

				it("should be able to work with throwing functions") {
					let value: Int? = 1
					expect { try value.take({ value in
						if value > 0 { throw TestError() }
						else { return value }
						})}.to(throwError())
				}

				it("should not throw error in valid cases") {
					let value: Int? = 1
					expect { try value.take {
						if $0 > 10 { throw TestError() }
						return $0
					}}.notTo(throwError())
				}

				it("should correctly apply closure with different type") {
					let value: Int? = 4
					expect(value.take { $0 > 0 } ).to(beTrue())
				}

				it("should correctly apply closure with the same type") {
					let value: Int? = 4
					expect(value.take { 10 * $0 } ).to(equal(40))
				}
			}
		}
	}
}
