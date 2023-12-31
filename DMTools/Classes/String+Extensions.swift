import Foundation
import UIKit

public class StringLocalizationInjection {
	public class func setPreferredLanguage(_ language: String) {
		guard let path = Bundle.main.path(forResource: language, ofType: "lproj") else {
			fatalError("Did not find injected language \(language)")
		}
		StringLocalizationInjection.languageBundle = Bundle(path: path)
	}

	internal static var languageBundle: Bundle?
}

public extension String {

	/**
	Localizes the provided string

	- returns: A localized string accordind to current locale
	*/
	@available(*, deprecated, message: "use localized computed property instead")
	func localize() -> String {
		return localized
	}

	/// Localizes self. Returns a localized string according to current locale
	var localized: String {
		let localizedString: String
		if let languageBundle = StringLocalizationInjection.languageBundle {
			localizedString = languageBundle.localizedString(forKey: self, value: nil, table: nil)
		} else {
			localizedString = NSLocalizedString(self, comment: "")
		}
		if localizedString == self {
			print("-------- UNLOCALIZED STRING \(self) --------")
		}
		return localizedString
	}

	/// Localizes self using provided table
	///
	/// - Parameter table: Name of file containing localization
	/// - Returns: Localized from table using locale
	func localized(in table: String) -> String {
		let localizedString: String
		if let languageBundle = StringLocalizationInjection.languageBundle {
			localizedString = languageBundle.localizedString(forKey: self, value: nil, table: table)
		} else {
			localizedString = NSLocalizedString(self, tableName: table, comment: "")
		}
		if localizedString == self {
			print("-------- UNLOCALIZED STRING \(self) --------")
		}
		return localizedString
	}

	/**
	Localizes with format. Use REVERSE to reverse format array. IE in Japanese when you want 30 out of 10 instead of 10 out of 30
	Expects format string to be located in localizable.strings with exact number of arguments as provided.
	- parameter arguments:	format arguments
	- parameter reverse:		should it reverse
	- returns: localized string.
	*/
	func localizeWithFormat(arguments: CVarArg..., reverse: Bool = false) -> String {
		let arguments = (reverse ? arguments.reversed() : arguments)
		return String(format: self.localized, arguments: arguments)
	}

	/**
	Transforms "a_really_really_long_text" to "aReallyReallyLongText"
	- returns: a String in camelcase
	*/
	func underscoreToCamelcase() -> String {
		return self.components(separatedBy: "_").enumerated().map({ (index: Int, element: String) -> String in
			return index != 0 ? element.capitalized : element
		}).joined()
	}

	/**
	Removes spaces from the String
	- returns: A provided String's copy without spaces
	*/
	func spacelessString() -> String {
		return self.replacingOccurrences(of: " ", with: "")
	}

	/**
	Counts width for string when height is known

	- parameter knownHeight: known height for string
	- parameter font: `UIFont` for string
	- returns: width for string
	*/
	func boundingWidth(knownHeight: CGFloat, font: UIFont) -> CGFloat {
		return boundingSize(with: CGSize(width: 1000, height: knownHeight), font: font).width
	}

	/**
	Counts height for string when width is known

	- parameter knownWidth: known width for string
	- parameter font: `UIFont` for string
	- returns: height for string
	*/
	func boundingHeight(knownWidth: CGFloat, font: UIFont) -> CGFloat {
		return boundingSize(with: CGSize(width: knownWidth, height: 1000), font: font).height
	}

	/**
	Counts size for string when one of the width or height is known and another is unknown

	- parameter size: if you have known width and you need to know height, put known width and very big height, and vice versa
	- parameter font: `UIFont` for string
	- returns: size for string
	*/
	func boundingSize(with size: CGSize, font: UIFont) -> CGSize {
		let fontAtributes: [NSAttributedString.Key: Any] = [.font: font]
		let rect = self.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: fontAtributes, context: nil)
		return CGSize(width: rect.width, height: rect.height)
	}

	/**
	Removes white spacing from the string

	- returns: string without white spacings
	*/
	func removeWhiteSpaces() -> String {
		return self.replacingOccurrences(of: " ", with: "")
	}

	/**
	Make capitalized first letter only in first word

	- returns: string with capitalized first letter in first word
	*/
	func capitalizedFirstLetter() -> String {
		return prefix(1).capitalized + dropFirst().lowercased()
	}
}
