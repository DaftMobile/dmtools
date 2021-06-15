import XCTest
import Quick

@testable import DMToolsTests

QCKMain([
	WeakArraySpec.self,
	ArraySpec.self,
	SequenceSpec.self,
	ArrayGenerationSpec.self,
	OptionalSpec.self,
	ArrayPermutationsSpec.self,
	IntFactorialSpec.self,
	CollectionSpec.self,
	LowPassFilterSignalSpec.self,
	StringExtensionSpec.self,
	TimeInterval_Extensions.self,
	JSONEncoder_SerializationSpec.self,
	JSONDecoder_SerializationSpec.self,
	Array_UniqSpec.self
])
