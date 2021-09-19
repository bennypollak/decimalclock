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
            Text(Date.timeParts(decimal: timeParts.decimal, hex: timeParts.hex, reverse: timeParts.reverse).string).font(Font.body.monospacedDigit())
            BinaryClock(timeParts: Date.timeParts(decimal: timeParts.decimal, hex: timeParts.hex, reverse: timeParts.reverse))
        }
    }
}

struct ContentView: View {
    let timer = Timer.publish(every: 0.007, on: .main, in: .common).autoconnect()
    @State var time = "time"
    @State private var hex = true
    @State private var reverse = false
    var gesture: some Gesture {
        DragGesture()
            .onChanged { drag in
        }
        .onEnded { drag in
            let w = drag.translation.width
            if w > 50 {
                self.reverse = false
            } else if w < -50 {
                self.reverse = true
            }
        }
    }
    var body: some View {
        VStack(spacing: 1) {
            Text("\(time)").font(Font.body.monospacedDigit()).frame(width: 0, height: 0, alignment: .top)
            AWClocks(timeParts: Date.timeParts(decimal: true, hex: self.hex, reverse: self.reverse))
            AWClocks(timeParts: Date.timeParts(decimal: false, reverse: self.reverse))
            Spacer()
            StickClock(timeParts: Date.timeParts(decimal: false, reverse: self.reverse)).frame(width:80, height:20)
        }.onReceive(timer) { input in
            self.time = Date.timeParts(decimal: true, hex: true, reverse: self.reverse).string
        }.onTapGesture(count: 2) {
            self.hex = !self.hex
        }.gesture(self.gesture)
        
    }
}

