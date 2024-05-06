//
//  SpelledClock.swift
//  dcw1
//
//  Created by Benny Pollak on 9/18/21.
//  Copyright © 2021 Alben Software. All rights reserved.
//

import SwiftUI
import UIKit
let zformatter = NumberFormatter()

struct SpelledView: View {
    var value = 0
    var invert: Bool = false
    func numberToMorse(value:Int) -> String {
        let morseMap = ["-----", ".----", "..---", "...--", "....-", ".....", "-....", "--...", "---..", "----."]
        // navigate through each character in the string value
        let digits = String(value).map { morseMap[Int(String($0))!] }
        // join the list of digits with a string in between
        return digits.joined(separator: "  ")
    }
    func spelled(value:Int) -> String {
        let morse = numberToMorse(value: value)
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        let regionCode = Locale.preferredLanguages[0] //Bundle.main.preferredLocalizations[0]
//        print(regionCode)
//        formatter.locale.regionCode
        //=
        formatter.locale = Locale(identifier: regionCode)
        return formatter.string(from: NSNumber(value: value))!
    }
    var body: some View {
        VStack(spacing:0) {
            Text("\(spelled(value:value).padding(toLength: 18, withPad: " ", startingAt: 0))").font(Font.custom("Courier", size: 17)).fixedSize(horizontal: false, vertical: true)
//                .multilineTextAlignment(.top)
                .frame(width:130, height:60)
        }
    }
}
struct SpelledsView: View {
    var value: Int
    var invert: Bool = false
    var body: some View {
        HStack(spacing:0) {
            SpelledView(value: value, invert: self.invert)
        }
    }
}
struct SpelledClock: View {
    var timeParts: TimeParts
    var invert: Bool = false
    var body: some View {
        HStack(spacing:3) {
            ForEach([timeParts.hours
                     , timeParts.mins, timeParts.secs], id: \.self) { timePart in
                SpelledsView(value:Int(timePart), invert: self.invert)
            }
        }
    }
}


struct SpelledClock_Previews: PreviewProvider {
    static var previews: some View {
        SpelledClock(timeParts: Date.timeParts(decimal: false), invert: false)
    }
}
