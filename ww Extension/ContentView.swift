//
//  ContentView.swift
//  ww Extension
//
//  Created by Benny Pollak on 7/12/20.
//  Copyright © 2020 Alben Software. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let timer = Timer.publish(every: 0.007, on: .main, in: .common).autoconnect()
    @State var time = "time"
    var body: some View {
        VStack(spacing: 1) {
            Text("\(time)").font(Font.body.monospacedDigit())
            BinaryClock(time: Date.timeParts(decimal: true), decimal: true)
            Text(Date.timeParts(decimal: false).string).font(Font.body.monospacedDigit())
            BinaryClock(time: Date.timeParts(decimal: false), decimal: false)
        }.onReceive(timer) { input in
            self.time = Date.timeParts(decimal: true).string
        }
    }
}

