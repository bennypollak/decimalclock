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
            Image(balls[parts[3]]).resizable().aspectRatio(contentMode: .fit)
            Image(balls[parts[2]]).resizable().aspectRatio(contentMode: .fit)
            Image(balls[parts[1]]).resizable().aspectRatio(contentMode: .fit)
            Image(balls[parts[0]]).resizable().aspectRatio(contentMode: .fit)
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
    func pad(string : String, toSize: Int) -> String {
        var padded = string
        for _ in 0..<(toSize - string.count) {
            padded = "0" + padded
        }
        return padded
    }
    
    func binParts(number: Double?) -> [[Int]] {
        let int = Int(number!)
        var result = [[1,0,1,0],[1,1,0,0]]
        let ho = int / 10
        let lo = int - ho*10
        let strs = [pad(string: String(ho, radix: 2), toSize: 4)
            , pad(string: String(lo, radix: 2), toSize: 4)]
        for i in 0..<2 {
            var s = 3
            for j in 0..<4 {
                result[i][j] = strs[i][s] == "1" ? 1 : 0
                s -= 1
            }
        }
        return result
    }
    var body: some View {
        HStack(spacing:3) {
            ByteView(parts:binParts(number: timeParts.hours))
            ByteView(parts:binParts(number: timeParts.mins))
            ByteView(parts:binParts(number: timeParts.secs))
        }        
    }
}

struct ContentView_PreviewsBinaryClock: PreviewProvider {
    let dtime = Date.timeParts(decimal: true)
    static var previews: some View {
        GeometryReader{g in
            VStack {
                BinaryClock(timeParts: Date.timeParts(decimal: true)).frame(width:150, height:150)
                Text("\( Date.timeParts(decimal: true).string)")
                BinaryClock(timeParts: Date.timeParts(decimal: false)).frame(width:150, height:150)
                Text("\( Date.timeParts(decimal: false).string)")
            }
            .frame(width: min(g.size.width,g.size.width), height: min(g.size.width,g.size.width), alignment: Alignment.center)
            
        }
        
    }
}
