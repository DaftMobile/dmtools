import Foundation

public extension Array {
	fileprivate static func generatePermutation<T>(_ identifier: Int, workingArray: [T], currentResults: inout [[T]]) {
		var workingArray = workingArray
		if identifier == 1 {
			currentResults.append(workingArray)
		} else {
			for counter in 0 ..< identifier - 1 {
				generatePermutation(identifier - 1, workingArray: workingArray, currentResults: &currentResults)
				if identifier % 2 == 1 {
					workingArray.swapAt(counter, identifier - 1)
				} else {
					workingArray.swapAt(0, identifier - 1)
				}
			}
			generatePermutation(identifier - 1, workingArray: workingArray, currentResults: &currentResults)
		}
	}

	func generatePermutations() -> [[Element]] {
		if isEmpty { return [[Element]]() }
		var toReturn = [[Element]]()
		Array.generatePermutation(self.count, workingArray: self, currentResults: &toReturn)
		return toReturn
	}
}
