//
//  RomanClock.swift
//  dcw1
//
//  Created by Benny Pollak on 9/18/21.
//  Copyright © 2021 Alben Software. All rights reserved.
//

import SwiftUI
struct RomanView: View {
    var value: Int
    var invert: Bool = false
    let values = ["","I","II","III","IV","V","VI","VII","VIII","IX","X",
                  "XI","XII","XIII","XIV","XV","XVI","XVII","XVIII","XIX","XX",
                  "XXI","XXII","XXIII","XXIV","XXV","XXVI","XXVII","XXVIII","XXIX","XXX",
                  "XXXI","XXXII","XXXIII","XXXIV","XXXV","XXXVI","XXXVII","XXXVIII","XXXIX","XL",
                  "XLI","XLII","XLIII","XLIV","XLV","XLVI","XLVII","XLVIII","XLIX","L",
                  "LI","LII","LIII","LIV","LV","LVI","LVII","LVIII","LIX","LX"
                  ]
    var body: some View {
        VStack(spacing:0) {
            Text("\(values[value].padding(toLength: 7, withPad: " ", startingAt: 0))").font(Font.custom("Courier", size: 18))
        }
    }
}
struct RomansView: View {
    var value: Int
    var invert: Bool = false
    var body: some View {
        HStack(spacing:0) {
            RomanView(value: value, invert: self.invert)
        }
    }
}
struct RomanClock: View {
    var timeParts: TimeParts
    var invert: Bool = false
    var body: some View {
        HStack(spacing:3) {
            ForEach([timeParts.hours
                     , timeParts.mins, timeParts.secs], id: \.self) { timePart in
                RomansView(value:Int(timePart), invert: self.invert)
            }
        }
    }
}


struct RomanClock_Previews: PreviewProvider {
    static var previews: some View {
        RomanClock(timeParts: Date.timeParts(decimal: false), invert: false)
    }
}
