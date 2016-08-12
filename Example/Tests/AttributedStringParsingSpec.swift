//
//  AttributedStringParsingSpec.swift
//  DMTools
//
//  Created by Kajetan Dąbrowski on 12/08/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation

import Quick
import Nimble

@testable import DMTools

class AttributedStringParsingSpec: QuickSpec {
	override func spec() {
		describe("AttributedStringParsing") {
			
			let baseFont = UIFont.systemFontOfSize(14)
			let baseAttributes: [String: AnyObject] = [
				NSFontAttributeName: baseFont,
				NSForegroundColorAttributeName: UIColor.whiteColor()
			]
			
			var sut: NSAttributedString!
			
			afterEach {
				sut = nil
			}
			
			context("when there are no special marks") {
				
				beforeEach {
					let startString = "This is a string"
					sut = NSAttributedString.parse(startString, attributes: baseAttributes, separatorSymbols: [])
					
				}
				
				it("have the same string inside") {
					expect(sut.string).to(equal("This is a string"))
				}
				
				it("should have correct font") {
					for i in 0..<sut.length {
						expect(sut.attribute(NSFontAttributeName, atIndex: i, effectiveRange: nil) as? UIFont).to(equal(baseFont))
					}
				}
				
				it("should have correct color") {
					for i in 0..<sut.length {
						expect(sut.attribute(NSForegroundColorAttributeName, atIndex: i, effectiveRange: nil) as? UIColor).to(equal(UIColor.whiteColor()))
					}
				}
			}
			
			context("when there are two special marks") {
				
				let specialMark: String = "^"
				let additionalAttributes: [String: AnyObject] = [
					NSForegroundColorAttributeName: UIColor.yellowColor()
				]
				
				
				beforeEach {
					let startString = "This ^is a^ string"
					sut = NSAttributedString.parse(startString, attributes: baseAttributes, separatorSymbols: [specialMark], additionalAttributes: additionalAttributes)
					
				}
				
				it("have the same string inside") {
					expect(sut.string).to(equal("This is a string"))
				}
				
				it("should have correct font") {
					for i in 0..<sut.length {
						expect(sut.attribute(NSFontAttributeName, atIndex: i, effectiveRange: nil) as? UIFont).to(equal(baseFont))
					}
				}
				
				it("should have correct color") {
					for i in 0..<5 {
						expect(sut.attribute(NSForegroundColorAttributeName, atIndex: i, effectiveRange: nil) as? UIColor).to(equal(UIColor.whiteColor()))
					}
					for i in 5..<9 {
						expect(sut.attribute(NSForegroundColorAttributeName, atIndex: i, effectiveRange: nil) as? UIColor).to(equal(UIColor.yellowColor()))
					}
					
					for i in 9..<sut.length {
						expect(sut.attribute(NSForegroundColorAttributeName, atIndex: i, effectiveRange: nil) as? UIColor).to(equal(UIColor.whiteColor()))
					}
				}
			}
			
			context("when creating a bold string") {
				let boldFont = UIFont.boldSystemFontOfSize(14)
				
				beforeEach {
					let startString = "<b>This<b> is a string and <b>this<b> should be <b>bolo<b>."
					sut = NSAttributedString.parse(startString, attributes: baseAttributes, separatorSymbols: ["<b>"], additionalAttributes: [NSFontAttributeName: boldFont])
				}
				
				it("have the same string inside") {
					expect(sut.string).to(equal("This is a string and this should be bolo."))
				}
				
				it("should have correct fonts") {
					let bolds = [0...3, 21...24, 36...39]
					let normals = [4...20, 25...35, 40...40]
					bolds.forEach({ (range) in
						for i in range {
							expect(sut.attribute(NSFontAttributeName, atIndex: i, effectiveRange: nil) as? UIFont).to(equal(boldFont))
						}
					})
					
					normals.forEach({ (range) in
						for i in range {
							expect(sut.attribute(NSFontAttributeName, atIndex: i, effectiveRange: nil) as? UIFont).to(equal(baseFont))
						}
					})
				}
			}
			
			context("when there are two different attributes") {
				
				beforeEach {
					let startString = "<red>0<red><blue>1<blue>"
					sut = NSAttributedString.parse(startString, attributes: [:], separatorsAndAttributesInside: ["<red>": [NSForegroundColorAttributeName: UIColor.redColor()], "<blue>": [NSForegroundColorAttributeName: UIColor.blueColor()]])
				}
				
				it("have the same string inside") {
					expect(sut.string).to(equal("01"))
				}
				
				it("should have correct attributes for 0") {
					let attributes = sut.attributesAtIndex(0, effectiveRange: nil)
					expect(attributes[NSForegroundColorAttributeName] as? UIColor).to(equal(UIColor.redColor()))
				}
				
				it("should have correct attributes for 1") {
					let attributes = sut.attributesAtIndex(1, effectiveRange: nil)
					expect(attributes[NSForegroundColorAttributeName] as? UIColor).to(equal(UIColor.blueColor()))
				}
				
			}
			
			context("when there are three different attributes") {
				let boldFont = UIFont.boldSystemFontOfSize(14)
				
				beforeEach {
					let startString = "<red>0<red><blue>1<blue><green>2<green><red>3<red><bold>4<bold>"
					sut = NSAttributedString.parse(startString, attributes: baseAttributes, separatorsAndAttributesInside: ["<red>": [NSForegroundColorAttributeName: UIColor.redColor()], "<blue>": [NSForegroundColorAttributeName: UIColor.blueColor()], "<green>": [NSForegroundColorAttributeName: UIColor.greenColor()], "<bold>": [NSFontAttributeName: boldFont]])
				}
				
				it("have the same string inside") {
					expect(sut.string).to(equal("01234"))
				}
				
				it("should have correct attributes for 0") {
					let attributes = sut.attributesAtIndex(0, effectiveRange: nil)
					expect(attributes[NSFontAttributeName] as? UIFont).to(equal(baseFont))
					expect(attributes[NSForegroundColorAttributeName] as? UIColor).to(equal(UIColor.redColor()))
				}
				
				it("should have correct attributes for 1") {
					let attributes = sut.attributesAtIndex(1, effectiveRange: nil)
					expect(attributes[NSFontAttributeName] as? UIFont).to(equal(baseFont))
					expect(attributes[NSForegroundColorAttributeName] as? UIColor).to(equal(UIColor.blueColor()))
				}
				
				it("should have correct attributes for 2") {
					let attributes = sut.attributesAtIndex(2, effectiveRange: nil)
					expect(attributes[NSFontAttributeName] as? UIFont).to(equal(baseFont))
					expect(attributes[NSForegroundColorAttributeName] as? UIColor).to(equal(UIColor.greenColor()))
				}
				
				it("should have correct attributes for 3") {
					let attributes = sut.attributesAtIndex(3, effectiveRange: nil)
					expect(attributes[NSFontAttributeName] as? UIFont).to(equal(baseFont))
					expect(attributes[NSForegroundColorAttributeName] as? UIColor).to(equal(UIColor.redColor()))
				}
				
				it("should have correct attributes for 4") {
					let attributes = sut.attributesAtIndex(4, effectiveRange: nil)
					expect(attributes[NSFontAttributeName] as? UIFont).to(equal(boldFont))
					expect(attributes[NSForegroundColorAttributeName] as? UIColor).to(equal(UIColor.whiteColor()))
				}
			}
		}
	}
}
