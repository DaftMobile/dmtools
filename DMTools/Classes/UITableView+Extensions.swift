//
//  UITableView+Extensions.swift
//  DaftCode
//
//  Created by Bartosz Kamiński on 13/06/16.
//  Copyright © 2016 DaftMobile. All rights reserved.
//

import Foundation

extension UITableView {

	/**
	Returns indexPath for last row in table view

	- returns: indexPath for last row in table view, nil if table view is empty
	*/
	func indexPathForLastRow() -> NSIndexPath? {
		if numberOfSections == 0 {
			return nil
		}
		let numberOfRowsInLastSection = numberOfRowsInSection(numberOfSections-1)
		return NSIndexPath(forRow: numberOfRowsInLastSection-1, inSection: numberOfSections-1)
	}
}