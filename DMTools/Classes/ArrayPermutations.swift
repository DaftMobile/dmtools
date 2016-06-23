//
//  Created by DaftMobile Sp z o. o.
//  Copyright (c) 2015 DaftMobile. All rights reserved.
//

import Foundation


public extension Array {
	private static func generatePermutation<T>(n: Int, workingArray: [T], inout currentResults: [[T]]) {
		var workingArray = workingArray
		if n == 1 {
			currentResults.append(workingArray)
		} else {
			for i in 0..<n-1 {
				generatePermutation(n-1, workingArray: workingArray, currentResults: &currentResults)
				if n % 2 == 1 {
					swap(&workingArray[i], &workingArray[n-1])
				} else {
					swap(&workingArray[0], &workingArray[n-1])
				}
			}
			generatePermutation(n-1, workingArray: workingArray, currentResults: &currentResults)
		}
	}

	public func generatePermutations() -> [[Element]] {
		if isEmpty { return [[Element]]() }
		var toReturn = [[Element]]()
		Array.generatePermutation(self.count, workingArray: self, currentResults: &toReturn)
		return toReturn
	}
}
