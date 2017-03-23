//
//  Collection+Extension.swift
//  Pods
//
//  Created by Bartosz Kamiński on 23/03/2017.
//
//

import Foundation

public extension Collection where Indices.Iterator.Element == Index {

	/**
	Access the `index`th element safely

	- returns: The `index`th element if exists, nil if not
	*/

	subscript (safe index: Index) -> Generator.Element? {
		return indices.contains(index) ? self[index] : nil
	}
}
