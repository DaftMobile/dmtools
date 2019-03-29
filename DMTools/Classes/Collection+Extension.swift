//
//  Collection+Extension.swift
//  Pods
//
//  Created by Bartosz Kamiński on 23/03/2017.
//
//

import Foundation

public extension Collection {

	/**
	Access the `index`th element safely
	
	- returns: The `index`th element if exists, nil if not
	*/

	subscript (safe index: Index) -> Iterator.Element? {
		return indices.contains(index) ? self[index] : nil
	}
}
