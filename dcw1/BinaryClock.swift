//
//  BinaryClock.swift
//  dcw1
//
//  Created by Benny Pollak on 7/4/20.
//  Copyright © 2020 Alben Software. All rights reserved.
//

import Foundation
import SwiftUI

struct NibbleView: View {
    var parts: [Int]
    let balls = ["blackball", "redball"]
    var body: some View {
        VStack(spacing:3) {
            ForEach(parts.reversed(), id: \.self) {  ball in
                Image(self.balls[ball]).resizable().aspectRatio(contentMode: .fit)
            }
        }
    }
}

struct ByteView: View {
    var parts: [[Int]]
    var body: some View {
        HStack(spacing:3) {
            NibbleView(parts: parts[0])
            NibbleView(parts: parts[1])
        }
    }
}
extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}

struct BinaryClock: View {
    var timeParts: TimeParts
    var ampm = true
    func pad(string : String, toSize: Int) -> String {
         return String(repeating: "0", count: toSize - string.count) + string
     }

    func binParts(number: Double?) -> [[Int]] {
        let int: Int = Int(number!)
        let mode = timeParts.hex ? 16 : 10
        let orders: [Int] = [
            int / mode,   //high order
            int % mode    //low order
        ]
        return orders.map {(order: Int) in
            pad(string: String(order, radix: 2), toSize:4).reversed().map {Int(String($0))!}
        }
    }

    var body: some View {
        HStack(spacing:3) {
            ForEach([self.ampm ? timeParts.hours.truncatingRemainder(dividingBy: timeParts.hex ? 128.0 : timeParts.decimal ? 50.0 : 12.0) : timeParts.hours, timeParts.mins, timeParts.secs], id: \.self) { timePart in
                ByteView(parts:binParts(number: timePart))
            }
        }
    }
}

struct ContentView_PreviewsBinaryClock: PreviewProvider {
    let dtime = Date.timeParts(decimal: true)
    static var previews: some View {
        GeometryReader{g in
            VStack {
                BinaryClock(timeParts: Date.timeParts(decimal: true, hex: true)).frame(width:150, height:150)
                Text("\( Date.timeParts(decimal: true).string)")
                BinaryClock(timeParts: Date.timeParts(decimal: false)).frame(width:150, height:150)
                Text("\( Date.timeParts(decimal: false).string)")
            }
            .frame(width: min(g.size.width,g.size.width), height: min(g.size.width,g.size.width), alignment: Alignment.center)
            
        }
        
    }
}
