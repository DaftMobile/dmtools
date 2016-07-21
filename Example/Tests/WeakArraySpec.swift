//
//  WeakArraySpec.swift
//  DMTools
//
//  Created by Kajetan Dąbrowski on 30/06/16.
//  Copyright © 2016 DaftMobile. All rights reserved.
//

import Foundation

import Quick
import Nimble

@testable
import DMTools

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
				var n0: IntWrapper!
				var n1: IntWrapper!
				var n2: IntWrapper!
				var n3: IntWrapper!
				
				beforeEach {
					n0 = IntWrapper(0)
					n1 = IntWrapper(1)
					n2 = IntWrapper(2)
					n3 = IntWrapper(3)
					
					sut.append(n0)
					sut.append(n1)
					sut.append(n2)
					sut.append(n3)
				}
				
				afterEach {
					n0 = nil
					n1 = nil
					n2 = nil
					n3 = nil
				}
				
				it("should have four elements") {
					expect(sut.count).to(equal(4))
				}
				
				it("should hold other elements") {
					n1 = nil
					expect(sut[0]).to(equal(n0))
					expect(sut[1]).to(beNil())
					expect(sut[2]).to(equal(n2))
					expect(sut[3]).to(equal(n3))
				}
				
				it("should not change array after consolidating") {
					sut.consolidate()
					expect(sut[0]).to(equal(n0))
					expect(sut[1]).to(equal(n1))
					expect(sut[2]).to(equal(n2))
					expect(sut[3]).to(equal(n3))
				}
				
				it("should remove unretained values from array when asked") {
					n1 = nil
					n2 = nil
					sut.consolidate()
					expect(sut.count).to(equal(2))
					expect(sut[0]).to(equal(n0))
					expect(sut[1]).to(equal(n3))
				}
				
				it("should correctly insert at index") {
					let n10 = IntWrapper(10)
					sut.insert(n10, atIndex: 2)
					expect(sut.count).to(equal(5))
					expect(sut[0]).to(equal(n0))
					expect(sut[1]).to(equal(n1))
					expect(sut[2]).to(equal(n10))
					expect(sut[3]).to(equal(n2))
					expect(sut[4]).to(equal(n3))
					
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
					n1 = nil
					n0 = nil
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
					sut.removeAtIndex(1)
					expect(sut[0]).to(equal(n0))
					expect(sut[1]).to(equal(n2))
					expect(sut[2]).to(equal(n3))
				}
				
				
			}
			
		}
	}
}