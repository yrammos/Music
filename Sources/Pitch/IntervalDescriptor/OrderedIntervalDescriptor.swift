//
//  OrderedIntervalDescriptor.swift
//  Pitch
//
//  Created by James Bean on 10/10/18.
//

import Algebra
import DataStructures

/// Descriptor for ordered interval between two `Pitch` values.
public struct OrderedIntervalDescriptor: IntervalDescriptor {

    // MARK: - Instance Properties

    /// The direction of a `OrderedIntervalDescriptor`.
    public let direction: Direction

    /// Ordinal value of a `OrderedIntervalDescriptor`
    /// (`unison`, `second`, `third`, `fourth`, `fifth`, `sixth`, `seventh`).
    public let ordinal: Ordinal

    /// IntervalQuality value of a `OrderedIntervalDescriptor`.
    /// (`diminished`, `minor`, `perfect`, `major`, `augmented`).
    public let quality: IntervalQuality
}

extension OrderedIntervalDescriptor {

    // MARK: - Initializers

    /// Creates an `OrderedIntervalDescriptor` with the given `direction`, `ordinal`, and `quality`.
    public init(
        _ direction: Direction = .ascending,
        _ ordinal: Ordinal,
        _ quality: IntervalQuality
    )
    {
        self.direction = direction
        self.ordinal = ordinal
        self.quality = quality
    }
}

extension OrderedIntervalDescriptor {

    // MARK: - Nested Types

    /// Direction of a `OrderedIntervalDescriptor`.
    public enum Direction: InvertibleEnum {
        case ascending, descending
    }

    /// Ordinal for `OrderedIntervalDescriptor`.
    public enum Ordinal: IntervalOrdinal {

        // MARK: - Cases

        /// Perfect ordered interval ordinal (unison, fourth, or fifth).
        case perfect(Perfect)

        /// Imperfect ordered interval ordinal (second, third, sixth, or seventh).
        case imperfect(Imperfect)

        /// - Returns: Inversion of `self`.
        ///
        ///     let third: Ordinal = .imperfect(.third)
        ///     third.inverse // => .imperfect(.sixth)
        ///     let fifth: Ordinal = .perfect(.fifth)
        ///     fifth.inverse // => .perfect(.fourth)
        ///
        public var inverse: OrderedIntervalDescriptor.Ordinal {
            switch self {
            case .perfect(let ordinal):
                return .perfect(ordinal.inverse)
            case .imperfect(let ordinal):
                return .imperfect(ordinal.inverse)
            }
        }

        /// The amount of diatonic steps represented by this `OrderedIntervalDescriptor.Ordinal`.
        public var steps: Int {
            switch self {
            case .perfect(let perfect):
                return perfect.rawValue
            case .imperfect(let imperfect):
                return imperfect.rawValue
            }
        }
    }
}

extension OrderedIntervalDescriptor.Ordinal {

    // MARK: - Nested Types

    /// Perfect `Ordinal` cases.
    public enum Perfect: Int, InvertibleEnum {

        // MARK: - Cases

        /// Fourth perfect ordered interval ordinal.
        case fourth = 3

        /// Unison perfect ordered interval ordinal.
        case unison = 0

        /// Fifth perfect ordered interval ordinal.
        case fifth = 4
    }

    /// Imperfect `Ordinal` cases
    public enum Imperfect: Int, InvertibleEnum {

        // MARK: - Cases

        /// Second imperfect ordered interval ordinal.
        case second = 1

        /// Third imperfect ordered interval ordinal.
        case third = 2

        /// Sixth imperfect ordered interval ordinal.
        case sixth = 5

        /// Seventh imperfect ordered interval ordinal.
        case seventh = 6
    }
}

extension OrderedIntervalDescriptor.Ordinal {

    // MARK: - Initializers

    /// Creates a `OrderedIntervalDescriptor` with the given amount of `steps`.
    public init?(steps: Int) {
        switch steps {
        case 0: self = .perfect(.unison)
        case 1: self = .imperfect(.second)
        case 2: self = .imperfect(.third)
        case 3: self = .perfect(.fourth)
        case 4: self = .perfect(.fifth)
        case 5: self = .imperfect(.sixth)
        case 6: self = .imperfect(.seventh)
        default: return nil
        }
    }

    /// Creates an `OrderedIntervalDescriptor` with the given `unordered` interval.
    ///
    /// - Warning: This is a lossless conversion.
    ///
    public init(_ unordered: UnorderedIntervalDescriptor.Ordinal) {
        switch unordered {
        case .perfect(let perfect):
            switch perfect {
            case .unison:
                self = .perfect(.unison)
            case .fourth:
                self = .perfect(.fourth)
            }
        case .imperfect(let imperfect):
            switch imperfect {
            case .second:
                self = .imperfect(.second)
            case .third:
                self = .imperfect(.third)
            }
        }
    }
}

extension OrderedIntervalDescriptor {

    // MARK: - Type Properties

    /// Unison.
    public static let unison = OrderedIntervalDescriptor(.perfect, .unison)

    /// Minor second.
    public static let m2 = OrderedIntervalDescriptor(.minor, .second)

    /// Major second.
    public static let M2 = OrderedIntervalDescriptor(.major, .second)

    /// Minor third.
    public static let m3 = OrderedIntervalDescriptor(.minor, .third)

    /// Major third.
    public static let M3 = OrderedIntervalDescriptor(.major, .third)

    /// Diminished fourth.
    public static let d4 = OrderedIntervalDescriptor(.diminished, .fourth)

    /// Perfect fourth.
    public static let P4 = OrderedIntervalDescriptor(.perfect, .fourth)

    /// Perfect fifth.
    public static let P5 = OrderedIntervalDescriptor(.perfect, .fifth)

    /// Augmented fourth.
    public static let A4 = OrderedIntervalDescriptor(.augmented, .fourth)

    /// Diminished fifth
    public static let d5 = OrderedIntervalDescriptor(.diminished, .fifth)

    /// Augmented fifth.
    public static let A5 = OrderedIntervalDescriptor(.augmented, .fifth)

    /// Minor sixth.
    public static let m6 = OrderedIntervalDescriptor(.minor, .sixth)

    /// Major sixth.
    public static let M6 = OrderedIntervalDescriptor(.major, .sixth)

    /// Minor seventh.
    public static let m7 = OrderedIntervalDescriptor(.minor, .seventh)

    /// Major seventh.
    public static let M7 = OrderedIntervalDescriptor(.major, .seventh)

    // TODO: Add diminished / augmented imperfect intervals
}

extension OrderedIntervalDescriptor {

    // MARK: - Initializers

    /// Creates an `OrderedIntervalDescriptor` with a given `quality` and `ordinal`.
    internal init(_ direction: Direction, _ quality: IntervalQuality, _ ordinal: Ordinal) {
        self.direction = direction
        self.quality = quality
        self.ordinal = ordinal
    }

    /// Creates an `OrderedIntervalDescriptor` with a given `quality` and `ordinal`.
    public init(_ quality: IntervalQuality, _ ordinal: Ordinal) {
        self.direction = .ascending
        self.quality = quality
        self.ordinal = ordinal
    }

    /// Creates a perfect `OrderedIntervalDescriptor`.
    ///
    ///     let perfectFifth = OrderedIntervalDescriptor(.perfect, .fifth)
    ///
    public init(_ quality: IntervalQuality.Perfect, _ ordinal: Ordinal.Perfect) {
        self.direction = .ascending
        self.quality = .perfect(.perfect)
        self.ordinal = .perfect(ordinal)
    }

    /// Creates a perfect `OrderedIntervalDescriptor` with a given `direction`.
    ///
    ///     let descendingPerfectFifth = OrderedIntervalDescriptor(.descending, .perfect, .fifth)
    ///
    public init(_ direction: Direction, _ quality: IntervalQuality.Perfect, _ ordinal: Ordinal.Perfect) {
        self.direction = direction
        self.quality = .perfect(.perfect)
        self.ordinal = .perfect(ordinal)
    }

    /// Creates an imperfect `OrderedIntervalDescriptor`.
    ///
    ///     let majorSecond = OrderedIntervalDescriptor(.major, .second)
    ///     let minorThird = OrderedIntervalDescriptor(.minor, .third)
    ///     let majorSixth = OrderedIntervalDescriptor(.major, .sixth)
    ///     let minorSeventh = OrderedIntervalDescriptor(.minor, .seventh)
    ///
    public init(_ quality: IntervalQuality.Imperfect, _ ordinal: Ordinal.Imperfect) {
        self.direction = .ascending
        self.quality = .imperfect(quality)
        self.ordinal = .imperfect(ordinal)
    }

    /// Creates an imperfect `OrderedIntervalDescriptor`.
    ///
    ///     let majorSecond = OrderedIntervalDescriptor(.ascending, .major, .second)
    ///     let minorThird = OrderedIntervalDescriptor(.descending, .minor, .third)
    ///     let majorSixth = OrderedIntervalDescriptor(.ascending, .major, .sixth)
    ///     let minorSeventh = OrderedIntervalDescriptor(.descending, .minor, .seventh)
    ///
    public init(
        _ direction: Direction,
        _ quality: IntervalQuality.Imperfect,
        _ ordinal: Ordinal.Imperfect
    )
    {
        self.direction = direction
        self.quality = .imperfect(quality)
        self.ordinal = .imperfect(ordinal)
    }

    /// Creates an augmented or diminished `OrderedIntervalDescriptor` with an imperfect ordinal. These
    /// intervals can be up to quintuple augmented or diminished.
    ///
    ///     let doubleDiminishedSecond = OrderedIntervalDescriptor(.double, .diminished, .second)
    ///     let tripleAugmentedThird = OrderedIntervalDescriptor(.triple, .augmented, .third)
    ///
    public init(
        _ degree: IntervalQuality.Extended.Degree,
        _ quality: IntervalQuality.Extended.AugmentedOrDiminished,
        _ ordinal: Ordinal.Imperfect
    )
    {
        self.direction = .ascending
        self.quality = .extended(.init(degree, quality))
        self.ordinal = .imperfect(ordinal)
    }

    /// Creates an augmented or diminished `OrderedIntervalDescriptor` with a given `direction` and an
    /// imperfect ordinal. These intervals can be up to quintuple augmented or diminished.
    ///
    ///     let doubleDiminishedSecond = OrderedIntervalDescriptor(.descending, .double, .diminished, .second)
    ///     let tripleAugmentedThird = OrderedIntervalDescriptor(.ascending, .triple, .augmented, .third)
    ///
    public init(
        _ direction: Direction,
        _ degree: IntervalQuality.Extended.Degree,
        _ quality: IntervalQuality.Extended.AugmentedOrDiminished,
        _ ordinal: Ordinal.Imperfect
    )
    {
        self.direction = direction
        self.quality = .extended(.init(degree, quality))
        self.ordinal = .imperfect(ordinal)
    }

    /// Creates an augmented or diminished `OrderedIntervalDescriptor` with a perfect ordinal. These
    /// intervals can be up to quintuple augmented or diminished.
    ///
    ///     let doubleAugmentedUnison = OrderedIntervalDescriptor(.double, .augmented, .unison)
    ///     let tripleDiminishedFourth = OrderedIntervalDescriptor(.triple, .diminished, .fourth)
    ///
    public init(
        _ degree: IntervalQuality.Extended.Degree,
        _ quality: IntervalQuality.Extended.AugmentedOrDiminished,
        _ ordinal: Ordinal.Perfect
    )
    {
        self.direction = .ascending
        self.quality = .extended(.init(degree, quality))
        self.ordinal = .perfect(ordinal)
    }

    /// Creates an augmented or diminished `OrderedIntervalDescriptor` with a given `direction` and a
    /// perfect ordinal. These intervals can be up to quintuple augmented or diminished.
    ///
    ///     let doubleAugmentedUnison = OrderedIntervalDescriptor(.descending, .double, .augmented, .unison)
    ///     let tripleDiminishedFourth = OrderedIntervalDescriptor(.ascending, .triple, .diminished, .fourth)
    ///
    public init(
        _ direction: Direction,
        _ degree: IntervalQuality.Extended.Degree,
        _ quality: IntervalQuality.Extended.AugmentedOrDiminished,
        _ ordinal: Ordinal.Perfect
        )
    {
        self.direction = direction
        self.quality = .extended(.init(degree, quality))
        self.ordinal = .perfect(ordinal)
    }

    /// Creates an augmented or diminished `OrderedIntervalDescriptor` with an imperfect ordinal.
    ///
    ///     let diminishedSecond = OrderedIntervalDescriptor(.diminished, .second)
    ///     let augmentedSixth = OrderedIntervalDescriptor(.augmented, .sixth)
    ///
    public init(_ quality: IntervalQuality.Extended.AugmentedOrDiminished, _ ordinal: Ordinal.Imperfect) {
        self.direction = .ascending
        self.quality = .extended(.init(.single, quality))
        self.ordinal = .imperfect(ordinal)
    }

    /// Creates an augmented or diminished `OrderedIntervalDescriptor` with a given `direction` and an
    /// imperfect ordinal.
    ///
    ///     let diminishedSecond = OrderedIntervalDescriptor(.descending, .diminished, .second)
    ///     let augmentedSixth = OrderedIntervalDescriptor(.ascending, .augmented, .sixth)
    ///
    public init(
        _ direction: Direction,
        _ quality: IntervalQuality.Extended.AugmentedOrDiminished,
        _ ordinal: Ordinal.Imperfect
    )
    {
        self.direction = direction
        self.quality = .extended(.init(.single, quality))
        self.ordinal = .imperfect(ordinal)
    }

    /// Creates an augmented or diminished `OrderedIntervalDescriptor` with a perfect ordinal.
    ///
    ///     let augmentedUnison = OrderedIntervalDescriptor(.augmented, .unison)
    ///     let diminishedFourth = OrderedIntervalDescriptor(.diminished, .fourth)
    ///
    public init(_ quality: IntervalQuality.Extended.AugmentedOrDiminished, _ ordinal: Ordinal.Perfect) {
        self.direction = .ascending
        self.quality = .extended(.init(.single, quality))
        self.ordinal = .perfect(ordinal)
    }

    /// Creates an augmented or diminished `OrderedIntervalDescriptor` with a given `direction` and a
    /// perfect ordinal.
    ///
    ///     let augmentedUnison = OrderedIntervalDescriptor(.ascending, .augmented, .unison)
    ///     let diminishedFourth = OrderedIntervalDescriptor(.descending, .diminished, .fourth)
    ///
    public init(
        _ direction: Direction,
        _ quality: IntervalQuality.Extended.AugmentedOrDiminished,
        _ ordinal: Ordinal.Perfect
    )
    {
        self.direction = direction
        self.quality = .extended(.init(.single, quality))
        self.ordinal = .perfect(ordinal)
    }
}

extension OrderedIntervalDescriptor: Invertible {

    // MARK: - Invertible

    /// - Returns: Inversion of `self`.
    public var inverse: OrderedIntervalDescriptor {
        return .init(direction.inverse, quality.inverse, ordinal.inverse)
    }
}

extension OrderedIntervalDescriptor: CustomStringConvertible {

    // MARK: - CustomStringConvertible

    /// Printable description of UnorderedIntervalDescriptor.
    public var description: String {
        return "\(quality)\(ordinal.steps + 1)\(direction == .descending ? "↓" : "")"
    }
}

extension OrderedIntervalDescriptor.Ordinal: Equatable, Hashable { }
extension OrderedIntervalDescriptor: Equatable, Hashable { }
