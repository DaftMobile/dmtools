//
//  HIGButton.swift
//  DMTools
//
//  Created by Bartosz Kamiński on 13/10/2017.
//

import Foundation
import UIKit

/// Provides a button that always complies with Apple Human Interface Guidelines by having hit area of at least 44x44
open class HIGButton: UIButton {

	// MARK: - Private Properties

	private let minimumHitArea: CGSize = CGSize(width: 44, height: 44)

	// MARK: - Public API

	override open func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
		let widthToAdd = max(minimumHitArea.width - bounds.size.width, 0)
		let heightToAdd = max(minimumHitArea.height - bounds.size.height, 0)
		let enlargedArea = bounds.insetBy(dx: -widthToAdd/2, dy: -heightToAdd/2)
		return enlargedArea.contains(point)
	}
}
