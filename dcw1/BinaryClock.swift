//
//  BinaryClock.swift
//  dcw1
//
//  Created by Benny Pollak on 7/4/20.
//  Copyright © 2020 Alben Software. All rights reserved.
//

import Foundation
import SwiftUI

struct BinaryNumber: View {
    var parts: [[Int]]
    var decimal: Bool = true
    let balls = ["blackball", "redball"]
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Image(balls[parts[0][3]]).resizable().aspectRatio(contentMode: .fit)
                    Image(balls[parts[0][2]]).resizable().aspectRatio(contentMode: .fit)
                    Image(balls[parts[0][1]]).resizable().aspectRatio(contentMode: .fit)
                    Image(balls[parts[0][0]]).resizable().aspectRatio(contentMode: .fit)
                }
                VStack {
                    Image(balls[parts[1][3]]).resizable().aspectRatio(contentMode: .fit)
                    Image(balls[parts[1][2]]).resizable().aspectRatio(contentMode: .fit)
                    Image(balls[parts[1][1]]).resizable().aspectRatio(contentMode: .fit)
                    Image(balls[parts[1][0]]).resizable().aspectRatio(contentMode: .fit)
                }
            }
        }
        
    }
}
extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}

struct BinaryClock: View {
    var time: TimeParts?
    var decimal: Bool = true
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
        HStack {
            BinaryNumber(parts:binParts(number: time!.hours))
            BinaryNumber(parts:binParts(number: time!.mins))
            BinaryNumber(parts:binParts(number: time!.secs))
        }
        
    }
}

struct ContentView_PreviewsBinaryClock: PreviewProvider {
    let dtime = Date.timeParts(decimal: true)
    static var previews: some View {
        GeometryReader{g in
            VStack {
                BinaryClock(time: Date.timeParts(decimal: true), decimal: true).frame(width:150, height:150)
                Text("\( Date.timeParts(decimal: true).string)")
                BinaryClock(time: Date.timeParts(decimal: false), decimal: false).frame(width:150, height:150)
                    Text("\( Date.timeParts(decimal: false).string)")
            }
            .frame(width: min(g.size.width,g.size.width), height: min(g.size.width,g.size.width), alignment: Alignment.center)

        }
        
    }
}
