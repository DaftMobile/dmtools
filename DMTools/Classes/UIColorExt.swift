import UIKit

public extension UIColor {
	/**
	Returns a `UIColor` with the specified hex value
	- parameter rgba: The hex of color in rgba `String` starting with `"#"`
	- returns: The desired color
	*/
	convenience init(rgba: String) {
		var red: CGFloat = 0.0
		var green: CGFloat = 0.0
		var blue: CGFloat = 0.0
		var alpha: CGFloat = 1.0

		if rgba.hasPrefix("#") {
			let index: String.Index = rgba.index(rgba.startIndex, offsetBy: 1)
			let hex: String = String(rgba[index..<rgba.endIndex])
			let scanner: Scanner = Scanner(string: hex)
			var hexValue: CUnsignedLongLong = 0
			if scanner.scanHexInt64(&hexValue) {
				switch hex.count {
				case 3:
					red = CGFloat((hexValue & 0xF00) >> 8) / 15.0
					green = CGFloat((hexValue & 0x0F0) >> 4) / 15.0
					blue = CGFloat(hexValue & 0x00F) / 15.0
				case 4:
					red = CGFloat((hexValue & 0xF000) >> 12) / 15.0
					green = CGFloat((hexValue & 0x0F00) >> 8) / 15.0
					blue = CGFloat((hexValue & 0x00F0) >> 4) / 15.0
					alpha = CGFloat(hexValue & 0x000F) / 15.0
				case 6:
					red = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
					green = CGFloat((hexValue & 0x00FF00) >> 8) / 255.0
					blue = CGFloat(hexValue & 0x0000FF) / 255.0
				case 8:
					red = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
					green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
					blue = CGFloat((hexValue & 0x0000FF00) >> 8) / 255.0
					alpha = CGFloat(hexValue & 0x000000FF) / 255.0
				default:
					print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8", terminator: "")
				}
			} else {
				print("Scan hex error")
			}
		} else {
			print("Invalid RGB string, missing '#' as prefix", terminator: "")
		}
		self.init(red: red, green: green, blue: blue, alpha: alpha)
	}
}
