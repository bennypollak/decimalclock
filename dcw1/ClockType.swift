//
//  ClockType.swift
//  dcw1
//
//  Created by Benny Pollak on 7/31/25.
//  Copyright © 2025 Alben Software. All rights reserved.
//
enum ClockType: Identifiable {
    case binary(decimal: Bool, hex: Bool, reverse: Bool, invert: Bool, ampm: Bool)
    case spelled(decimal: Bool, hex: Bool, reverse: Bool, invert: Bool, ampm: Bool)
    case morse(decimal: Bool, hex: Bool, reverse: Bool, invert: Bool, ampm: Bool)
    case braille(decimal: Bool, hex: Bool, reverse: Bool, invert: Bool, ampm: Bool)
    case roman(decimal: Bool, hex: Bool, reverse: Bool, invert: Bool, ampm: Bool)
    case stick(decimal: Bool, hex: Bool, reverse: Bool, invert: Bool, ampm: Bool)

    var id: String {
        switch self {
        case let .binary(d, h, r, i, a): return "binary-\(d)-\(h)-\(r)-\(i)-\(a)"
        case let .spelled(d, h, r, i, a): return "spelled-\(d)-\(h)-\(r)-\(i)-\(a)"
        case let .morse(d, h, r, i, a): return "morse-\(d)-\(h)-\(r)-\(i)-\(a)"
        case let .braille(d, h, r, i, a): return "braille-\(d)-\(h)-\(r)-\(i)-\(a)"
        case let .roman(d, h, r, i, a): return "roman-\(d)-\(h)-\(r)-\(i)-\(a)"
        case let .stick(d, h, r, i, a): return "stick-\(d)-\(h)-\(r)-\(i)-\(a)"
        }
    }

    var settings: (decimal: Bool, hex: Bool, reverse: Bool, invert: Bool, ampm: Bool) {
        switch self {
        case let .binary(d, h, r, i, a),
             let .spelled(d, h, r, i, a),
             let .morse(d, h, r, i, a),
             let .braille(d, h, r, i, a),
             let .roman(d, h, r, i, a),
             let .stick(d, h, r, i, a):
            return (d, h, r, i, a)
        }
    }
}
