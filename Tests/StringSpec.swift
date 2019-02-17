//
//  StringSpec.swift
//  DMTools
//
//  Created by Kajetan Dąbrowski on 11/08/16.
//  Copyright © 2016 DaftMobile. All rights reserved.
//

import Foundation

import Quick
import Nimble

@testable import DMTools

class StringExtensionSpec: QuickSpec {
	override func spec() {
		describe("String Extension") {
			
			context("when localizing a string with two integer variables") {
				
				let startFormat = "Your score: %d out of %d"
				
				it("should localize in English correctly") {
					expect(startFormat.localizeWithFormat(arguments: 10, 30)).to(equal("Your score: 10 out of 30"))
					expect(startFormat.localizeWithFormat(arguments: 10, 30, reverse: false)).to(equal("Your score: 10 out of 30"))
				}
				
				it("should correctly reverse in Japanese") {
					expect(startFormat.localizeWithFormat(arguments: 10, 30, reverse: true)).to(equal("Your score: 30 out of 10"))
				}
			}
			
		}
	}
}
