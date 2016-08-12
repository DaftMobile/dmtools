//
//  AttributedString+Parsing.swift
//  Pods
//
//  Created by Kajetan Dąbrowski on 12/08/16.
//
//

import Foundation

public extension NSAttributedString {
	
	class func parse(string: String, attributes: [String: AnyObject], separatorSymbols: [String], additionalAttributes: [String: AnyObject]? = nil) -> NSAttributedString {
		
		var parts: [String] = [string]
		separatorSymbols.forEach { (separator) -> Void in
			parts = parts.flatMap({return $0.componentsSeparatedByString(separator) })
		}
		
		var separatedAttributes = attributes
		if let additionalAttributes = additionalAttributes {
			for (attribute, value) in additionalAttributes {
				separatedAttributes[attribute] = value
			}
		}
		
		var attributedString = NSMutableAttributedString()
		
		for i in 0..<parts.count {
			let nextPart = parts[i]
			let nextAttributes = ((i % 2 == 0) ? attributes : separatedAttributes)
			attributedString.appendAttributedString(NSAttributedString(string: nextPart, attributes: nextAttributes))
		}
		return NSAttributedString(attributedString: attributedString)
	}
}
