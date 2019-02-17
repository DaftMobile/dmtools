//
//  CollectionSpec.swift
//  DMTools
//
//  Created by Bartosz Kamiński on 23/03/2017.
//  Copyright © 2017 DaftMobile. All rights reserved.
//

import Foundation

import Quick
import Nimble

@testable import DMTools

class CollectionSpec: QuickSpec {
	override func spec() {
		describe("Collection") {

			describe("Equatable") {

				var array: [Int]?

				beforeEach {
					array = [0, 1, 2]
				}

				context("when accessed existing index") {

					it("should provide element at this index") {
						expect(array?[safe: 0]).to(equal(0))
					}
				}

				context("when accessed not existing index") {

					it("should return nil") {
						expect(array?[safe: 5]).to(beNil())
					}
				}
			}

			describe("Not equatable") {

				struct TestStruct {
					var number: Int
				}

				var array: [TestStruct]?

				beforeEach {
					array = [TestStruct(number: 0), TestStruct(number: 1)]
				}

				context("when accessed existing index") {

					it("should provide element at this index") {
						expect(array?[safe: 0]?.number).to(equal(0))
					}
				}

				context("when accessed not existing index") {

					it("should return nil") {
						expect(array?[safe: 5]).to(beNil())
					}
				}
			}

		}
	}
}
