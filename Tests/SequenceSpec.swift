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

class SequenceSpec: QuickSpec {
	override func spec() {
		describe("Sequence") {
			describe("Group") {

				it("should Correctly group empty sequence") {
					let sequence: [Int] = []
					let grouped = sequence.group { $0 > 10 }
					expect(grouped.count).to(equal(0))
					expect(grouped[true]).to(beNil())
					expect(grouped[false]).to(beNil())
				}

				it("should Correctly group where there are no elements in one group") {
					let sequence = [1, 2, 3, 1]
					let grouped = sequence.group { $0 > 10 }
					expect(grouped.count).to(equal(1))
					expect(grouped[true]).to(beNil())
					expect(grouped[false]).notTo(beNil())
					expect(grouped[false]?.count).to(equal(4))
				}

				it("should correctly group where there are items in both groups") {
					let sequence = [1, 2, 3, 1, 10, 4, 2, 34289374, 12312, 2, 34]
					let grouped = sequence.group { $0 > 10 }
					expect(grouped.count).to(equal(2))
					expect(grouped[true]).notTo(beNil())
					expect(grouped[false]).notTo(beNil())
					expect(grouped[true]?.count).to(equal(3))
					expect(grouped[false]?.count).to(equal(8))
				}

				it("should correctly group by self") {
					let sequence = [23242, 34, 234, 45, 45, 344]
					let grouped = sequence.group { $0 }
					expect(grouped.count).to(equal(5))
					expect(grouped[4]?.count).to(beNil())
					expect(grouped[34]?.count).to(equal(1))
					expect(grouped[34]?.first).to(equal(34))
					expect(grouped[45]?.count).to(equal(2))
					expect(grouped[45]?.first).to(equal(45))
					expect(grouped[45]?.last).to(equal(45))
				}
			}

			describe("Divide") {
				it("should correctly divide empty array") {
					let sequence: [Int] = []
					let (slice, remainder) = sequence.divide { $0 > 0 }
					expect(slice).to(beEmpty())
					expect(remainder).to(beEmpty())
				}

				it("should correctly divie one element array") {
					let sequence = [1]
					let (slice, remainder) = sequence.divide { $0 < 0 }
					expect(slice).to(beEmpty())
					expect(remainder.count).to(equal(1))
				}

				it("should correctly divie one element array 2") {
					let sequence = [1]
					let (slice, remainder) = sequence.divide { $0 > 0 }
					expect(slice.count).to(equal(1))
					expect(remainder).to(beEmpty())
				}

				it("should correctly split complex array") {
					let sequence = [0, 45, 23, 7, 234, 7, 23, 7, 9, 5, 4, 1, 456, 657, 4, 5234, 23, 4352]
					let (slice, remainder) = sequence.divide { $0 >= 100 }
					expect(slice).to(equal([234, 456, 657, 5234, 4352]))
					expect(remainder).to(equal([0, 45, 23, 7, 7, 23, 7, 9, 5, 4, 1, 4, 23]))
				}
			}
		}
	}
}
