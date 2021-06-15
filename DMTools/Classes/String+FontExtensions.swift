#if os(iOS)
import Foundation
import UIKit

public extension String {
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
}

#endif
