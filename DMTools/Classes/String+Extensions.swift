//
//  String+Extensions.swift
//  FingerHero
//
//  Created by Gabriel Żołnierczuk on 05.05.2015.
//  Copyright (c) 2015 DaftMobile. All rights reserved.
//

import Foundation

public extension String {

	/**
	Localizes the provided string

	- returns: A localized string accordind to current locale
	*/
	func localize() -> String {
		let localizedString: String = NSLocalizedString(self, comment: "")
		if localizedString == self {print("-------- UNLOCALIZED STRING \(self) --------")}
		return localizedString
	}


	/**
	Transforms "a_really_really_long_text" to "aReallyReallyLongText"

	- returns: a String in camelcase
	*/
	func underscoreToCamelcase() -> String {
		return self.componentsSeparatedByString("_").enumerate().map({ (index: Int, element: String) -> String in
			return index != 0 ? element.capitalizedString : element
		}).joinWithSeparator("")
	}

	/**
	Removes spaces from the String

	- returns: A provided String's copy without spaces
	*/
	func spacelessString() -> String {
		return self.stringByReplacingOccurrencesOfString(" ", withString: "")
	}
}
