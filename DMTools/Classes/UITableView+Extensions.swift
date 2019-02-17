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
	public func indexPathForLastRow() -> IndexPath? {
		if numberOfSections == 0 {
			return nil
		}
		let numberOfRowsInLastSection = numberOfRows(inSection: numberOfSections - 1)
		return IndexPath(row: numberOfRowsInLastSection - 1, section: numberOfSections - 1)
	}
}
