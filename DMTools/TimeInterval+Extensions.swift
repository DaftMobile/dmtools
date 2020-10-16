import Foundation

public extension TimeInterval {
	init(minutes: Int) {
		self.init(60 * minutes)
	}

	init(hours: Int) {
		self.init(minutes: 60 * hours)
	}

	init(days: Int) {
		self.init(hours: 24 * days)
	}

	var minutes: Int {
		return Int(self / 60)
	}

	var hours: Int {
		return Int(minutes / 60)
	}

	var days: Int {
		return Int(hours / 24)
	}
}
