//
//  BrailleClock.swift
//  dcw1
//
//  Created by Benny Pollak on 5/4/24.
//  Copyright © 2024 Alben Software. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

struct BrailleView: View {
    var value = 0
    var invert: Bool = false
    func numberToBraille(value:Int) -> String {
        let brailleMap = ["⠴","⠂","⠆","⠒","⠲","⠢","⠖","⠶","⠦","⠔"]
        var digits = String(value).map { brailleMap[Int(String($0))!] }
        if digits.count == 1 { digits.insert(brailleMap[0], at: 0) }
       return digits.joined(separator: "  ")
    }
    var body: some View {
        VStack(spacing:0) {
            Text("\(numberToBraille(value:value).padding(toLength: 18, withPad: " ", startingAt: 0))").font(Font.custom("Courier", size: 30)).fixedSize(horizontal: false, vertical: true)
                .frame(width:130, height:50)
        }
    }
}
struct BraillesView: View {
    var value: Int
    var invert: Bool = false
    var body: some View {
        HStack(spacing:0) {
            BrailleView(value: value, invert: self.invert)
        }
    }
}
struct BrailleClock: View {
    var timeParts: TimeParts
    var invert: Bool = false
    var body: some View {
        HStack(spacing:3) {
            ForEach([timeParts.hours
                     , timeParts.mins, timeParts.secs], id: \.self) { timePart in
                BraillesView(value:Int(timePart), invert: self.invert)
            }
        }
    }
}


struct BrailleClock_Previews: PreviewProvider {
    static var previews: some View {
        BrailleClock(timeParts: Date.timeParts(decimal: false), invert: false)
    }
}
