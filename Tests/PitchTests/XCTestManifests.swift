import XCTest

extension FrequencyTests {
    static let __allTests = [
        ("testInitIntLiteral", testInitIntLiteral),
    ]
}

extension NoteNumberTests {
    static let __allTests = [
        ("testNoteNumberInit", testNoteNumberInit),
        ("testQuantizedFromArbitraryToEighthStep", testQuantizedFromArbitraryToEighthStep),
        ("testQuantizedFromArbitraryToQuarterStep", testQuantizedFromArbitraryToQuarterStep),
        ("testQuantizedFromArbitraryToWholeStep", testQuantizedFromArbitraryToWholeStep),
        ("testQuantizedFromEighthToQuarterStep", testQuantizedFromEighthToQuarterStep),
        ("testRandom", testRandom),
    ]
}

extension PitchClassDyadTests {
    static let __allTests = [
        ("testEquality", testEquality),
        ("testEqualityNotEqual", testEqualityNotEqual),
        ("testOrderedIntervalCrossOver", testOrderedIntervalCrossOver),
        ("testOrderedIntervalEasy", testOrderedIntervalEasy),
    ]
}

extension PitchClassIntervalTests {
    static let __allTests = [
        ("testInit", testInit),
    ]
}

extension PitchClassSetTests {
    static let __allTests = [
        ("testEquality", testEquality),
    ]
}

extension PitchClassTests {
    static let __allTests = [
        ("testAdd", testAdd),
        ("testPitchClass", testPitchClass),
        ("testPitchClassInitFloatGreaterThan12", testPitchClassInitFloatGreaterThan12),
        ("testPitchClassInitFloatLessThan12", testPitchClassInitFloatLessThan12),
        ("testPitchClassInitIntGreaterThan12", testPitchClassInitIntGreaterThan12),
        ("testPitchClassInitIntLessThan12", testPitchClassInitIntLessThan12),
        ("testPitchClassInitWithFloat", testPitchClassInitWithFloat),
        ("testSubtract", testSubtract),
    ]
}

extension PitchDyadTests {
    static let __allTests = [
        ("testDescription", testDescription),
        ("testEqualityFalseHigherNotEqual", testEqualityFalseHigherNotEqual),
        ("testEqualityFalseLowerNotEqual", testEqualityFalseLowerNotEqual),
        ("testEqualityFalseNeitherEqual", testEqualityFalseNeitherEqual),
        ("testEqualityTrue", testEqualityTrue),
        ("testInitOrdered", testInitOrdered),
        ("testInterval", testInterval),
    ]
}

extension PitchIntervalTests {
    static let __allTests = [
        ("testEquatable", testEquatable),
        ("testInit", testInit),
    ]
}

extension PitchSegmentTests {
    static let __allTests = [
        ("testNormalFormSinglePitch", testNormalFormSinglePitch),
        ("testNormalFormWrapping", testNormalFormWrapping),
        ("testPrimeForm", testPrimeForm),
        ("testPrimeFormsEqual", testPrimeFormsEqual),
    ]
}

extension PitchSetTests {
    static let __allTests = [
        ("testDyads", testDyads),
        ("testPitchClassSet", testPitchClassSet),
    ]
}

extension PitchTests {
    static let __allTests = [
        ("testFloatMinusPitch", testFloatMinusPitch),
        ("testFloatPlusPitch", testFloatPlusPitch),
        ("testInit", testInit),
        ("testInitWithPitch", testInitWithPitch),
        ("testPitchMinusFloat", testPitchMinusFloat),
        ("testPitchPlusFloat", testPitchPlusFloat),
        ("testPrintDescription", testPrintDescription),
        ("testRandom", testRandom),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(FrequencyTests.__allTests),
        testCase(NoteNumberTests.__allTests),
        testCase(PitchClassDyadTests.__allTests),
        testCase(PitchClassIntervalTests.__allTests),
        testCase(PitchClassSetTests.__allTests),
        testCase(PitchClassTests.__allTests),
        testCase(PitchDyadTests.__allTests),
        testCase(PitchIntervalTests.__allTests),
        testCase(PitchSegmentTests.__allTests),
        testCase(PitchSetTests.__allTests),
        testCase(PitchTests.__allTests),
    ]
}
#endif