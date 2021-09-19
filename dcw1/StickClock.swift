//
//  StickClock.swift
//  dcw1
//
//  Created by Benny Pollak on 9/18/21.
//  Copyright © 2021 Alben Software. All rights reserved.
//

import SwiftUI

struct StickView: View {
    var parts: [Int]
    var invert: Bool = false
    let balls = ["0s", "1s", "2s", "3s", "4s", "5s"]
    var body: some View {
        VStack(spacing:0) {
            ForEach(parts.reversed(), id: \.self) {  ball in
                Image((invert ? "i" : "")+self.balls[ball]).resizable().aspectRatio(contentMode: .fit)
            }
        }
    }
}
struct SticksView: View {
    var parts: [[Int]]
    var invert: Bool = false
    var body: some View {
        HStack(spacing:1) {
            StickView(parts: parts[0], invert: self.invert)
            StickView(parts: parts[1], invert: self.invert)
        }
    }
}
struct StickClock: View {
    var timeParts: TimeParts
    var invert: Bool = false
    func pad(string : String, toSize: Int) -> String {
         return String(repeating: "0", count: toSize - string.count) + string
     }
    func stickParts(number: Double?) -> [[Int]] {
        let int: Int = Int(number!)
        let mode = 10
        let orders: [Int] = [
            int / mode,   //high order
            int % mode    //low order
        ]
        var times:[[Int]] = []
        if orders[0] < 5 {
            times.append([0,orders[0]])
        } else {
            times.append([orders[0]-5,5])
        }
        if orders[1] < 5 {
            times.append([0,orders[1]])
        } else {
            times.append([orders[1]-5,5])
        }
        return times
    }
    var body: some View {
        VStack(spacing:3) {
            HStack(spacing:3) {
                ForEach([timeParts.hours
                         , timeParts.mins, timeParts.secs], id: \.self) { timePart in
                    SticksView(parts:stickParts(number: timePart), invert: self.invert)
                }
            }
        }
    }
}


struct StickClock_Previews: PreviewProvider {
    static var previews: some View {
        StickClock(timeParts: Date.timeParts(decimal: false), invert: false)
    }
}
