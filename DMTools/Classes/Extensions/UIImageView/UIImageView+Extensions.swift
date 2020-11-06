import UIKit
import AVFoundation

public extension UIImageView {

	/**
	- returns: Frame of `UIImage` inside `UIImageView`
	*/
	func imageFrame() -> CGRect {
		return AVMakeRect(aspectRatio: image?.size ?? .zero, insideRect: frame)
	}
}
