//
//  ContentView.swift
//  ww Extension
//
//  Created by Benny Pollak on 7/12/20.
//  Copyright © 2020 Alben Software. All rights reserved.
//

import SwiftUI
struct AWClocks : View {
    var timeParts: TimeParts
    var body: some View {
        VStack(spacing:0) {
            Text(Date.timeParts(decimal: timeParts.decimal, hex: timeParts.hex).string).font(Font.body.monospacedDigit())
            BinaryClock(timeParts: Date.timeParts(decimal: timeParts.decimal, hex: timeParts.hex))
        }
    }
}

struct ContentView: View {
    let timer = Timer.publish(every: 0.007, on: .main, in: .common).autoconnect()
    @State var time = "time"
    var body: some View {
        VStack(spacing: 1) {
            Text("\(time)").font(Font.body.monospacedDigit()).frame(width: 0, height: 0, alignment: .top)
            AWClocks(timeParts: Date.timeParts(decimal: true, hex: true))
            AWClocks(timeParts: Date.timeParts(decimal: false))
        }.onReceive(timer) { input in
            self.time = Date.timeParts(decimal: true, hex: true).string
        }
    }
}

