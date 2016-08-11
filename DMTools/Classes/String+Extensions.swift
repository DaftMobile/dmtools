//
//  Created by DaftMobile Sp z o. o.
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
	Localizes with format. Use REVERSE to reverse format array. IE in Japanese when you want 30 out of 10 instead of 10 out of 30
	Expects format string to be located in localizable.strings with exact number of arguments as provided.
	
	- parameter arguments:	format arguments
	- parameter reverse:		should it reverse
	
	- returns: localized string.
	*/
	func localizeWithFormat(arguments arguments: CVarArgType..., reverse: Bool = false) -> String {
		let arguments = (reverse ? arguments.reverse() : arguments)
		return String.init(format: self.localize(), arguments: arguments)
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
