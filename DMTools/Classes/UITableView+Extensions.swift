//
//  Created by DaftMobile Sp z o. o.
//  Copyright (c) 2015 DaftMobile. All rights reserved.
//

import Foundation

public extension UITableView {

	/**
	Returns indexPath for last row in table view

	- returns: indexPath for last row in table view, nil if table view is empty
	*/
	public func indexPathForLastRow() -> NSIndexPath? {
		if numberOfSections == 0 {
			return nil
		}
		let numberOfRowsInLastSection = numberOfRowsInSection(numberOfSections-1)
		return NSIndexPath(forRow: numberOfRowsInLastSection-1, inSection: numberOfSections-1)
	}
}