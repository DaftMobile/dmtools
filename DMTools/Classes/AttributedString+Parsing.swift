//
//  AttributedString+Parsing.swift
//  Pods
//
//  Created by Kajetan Dąbrowski on 12/08/16.
//
//

import Foundation

public extension NSAttributedString {

	class func parse(_ string: String, attributes: [NSAttributedString.Key: Any], separatorSymbols: [String], additionalAttributes: [NSAttributedString.Key: Any]? = nil) -> NSAttributedString {
		var separatorSymbolsAndAttributes: [String: [NSAttributedString.Key: Any]] = [:]
		for symbol in separatorSymbols {
			separatorSymbolsAndAttributes[symbol] = additionalAttributes
		}
		return self.parse(string, attributes: attributes, separatorsAndAttributesInside: separatorSymbolsAndAttributes)
	}

	class func parse(_ string: String, attributes: [NSAttributedString.Key: Any], separatorsAndAttributesInside: [String: [NSAttributedString.Key: Any]]) -> NSAttributedString {

		var parts: [(String, [NSAttributedString.Key: Any])] = [(string, attributes)]

		for (separator, specialAttributes) in separatorsAndAttributesInside {

			var newParts: [(String, [NSAttributedString.Key: Any])] = []
			for index in 0..<parts.count {
				var stageParts: [(String, [NSAttributedString.Key: Any])] = []

				let separatedParts = parts[index].0.components(separatedBy: separator)
				for separatedPart in separatedParts {
					stageParts.append((separatedPart, parts[index].1))
				}
				for innerIndex in 0..<stageParts.count {
					var startingAttributes = stageParts[innerIndex].1
					if innerIndex % 2 == 1 {
						for (attribute, value) in specialAttributes {
							startingAttributes[attribute] = value
						}
					}
					stageParts[innerIndex].1 = startingAttributes
				}
				newParts.append(contentsOf: stageParts)
			}
			parts = newParts
		}

		let attributedString = NSMutableAttributedString()
		for (finalString, finalAttributes) in parts {
			attributedString.append(NSAttributedString(string: finalString, attributes: finalAttributes))
		}
		return NSAttributedString(attributedString: attributedString)
	}
}
