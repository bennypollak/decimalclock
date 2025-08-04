//
//  MorseClock.swift
//  dcw1
//
//  Created by Benny Pollak on 5/4/24.
//  Copyright © 2024 Alben Software. All rights reserved.
//


import SwiftUI
import UIKit

struct MorseView: View {
    var value = 0
    var invert: Bool = false
    func numberToMorse(value:Int) -> String {
        let morseMap = ["-----", ".----", "..---", "...--", "....-", ".....", "-....", "--...", "---..", "----."]
        var digits = String(value).map { morseMap[Int(String($0))!] }
        if digits.count == 1 { digits.insert(morseMap[0], at: 0) }
        return digits.joined(separator: "  ")
    }
    var body: some View {
        VStack(spacing:0) {
            Text("\(numberToMorse(value:value).padding(toLength: 18, withPad: " ", startingAt: 0))").font(Font.custom("Courier", size: 17)).fixedSize(horizontal: false, vertical: true)
                .frame(width:130, height:20)
        }
    }
}
struct MorsesView: View {
    var value: Int
    var invert: Bool = false
    var body: some View {
        HStack(spacing:0) {
            MorseView(value: value, invert: self.invert)
        }
    }
}
struct MorseClock: View {
    var timeParts: TimeParts
    var invert: Bool = false
    var body: some View {
        HStack(spacing:3) {
            ForEach([timeParts.hours
                     , timeParts.mins, timeParts.secs], id: \.self) { timePart in
                MorsesView(value:Int(timePart), invert: self.invert)
            }
        }
    }
}


struct MorseClock_Previews: PreviewProvider {
    static var previews: some View {
        SpelledClock(timeParts: Date.timeParts(decimal: false), invert: false)
    }
}
