//
//  ContentView.swift
//  dcw1
//
//  Created by Benny Pollak on 6/20/20.
//  Copyright © 2020 Alben Software. All rights reserved.
//

import SwiftUI

struct AClocks : View {
    var timeParts: TimeParts
    var ampm = true
    var body: some View {
        VStack(spacing:0) {
            Text(timeParts.hex ? "Hex" : timeParts.decimal ? "Decimal" : "Standard (legacy)")
            HStack {
                Text("\(timeParts.string)").font(.system(size: 14, design: .monospaced)).multilineTextAlignment(.leading)
                Text("\(timeParts.stringAP)").font(.system(size: 14, design: .monospaced)).multilineTextAlignment(.leading)
            }
            VStack(spacing:0) {
                Clock(timeParts: Date.timeParts(decimal: timeParts.decimal, hex: timeParts.hex, reverse: timeParts.reverse))
                BinaryClock(timeParts: Date.timeParts(decimal: timeParts.decimal, hex: timeParts.hex, reverse: timeParts.reverse), ampm: self.ampm)
                    .frame(width:80, height:70)
            }
        }
    }
}

struct ContentView: View {
    @State var time = Date()
    @State private var clockOrder = true
    @State private var hex = true
    @State private var reverse = false
    @State private var ampm = true
    @State private var selectedClock: ClockType? = nil
    var i = 0

    let timer = Timer.publish(every: 0.001, on: .main, in: .common).autoconnect()
    
    var gesture: some Gesture {
        DragGesture()  
            .onChanged { drag in
//                if self.didJustSwipe {
//                    self.didJustSwipe = false
//                }
        }
        .onEnded { drag in
            let w = drag.translation.width
            let h = drag.translation.height
            if abs(h) > 100 {
//                self.hex = !self.hex
                self.clockOrder = !self.clockOrder
            }
            if w > 100 {
                self.reverse = false
            } else if w < -100 {
                self.reverse = true
            }
        }
    }
    var body: some View {
        
        VStack(spacing:0) {
            AClocks(timeParts: Date.timeParts(decimal: false, reverse: self.reverse), ampm: self.ampm).onTapGesture { selectedClock = .binary(decimal: false, hex: false, reverse: reverse, invert: !self.clockOrder, ampm: self.ampm) }
            Spacer()
            VStack(spacing:0) {
                HStack {
                    AClocks(timeParts: Date.timeParts(decimal: true, hex: false, reverse: self.reverse), ampm: self.ampm).onTapGesture { selectedClock = .binary(decimal: true, hex: false, reverse: self.reverse, invert: !self.clockOrder, ampm: self.ampm) }
                    AClocks(timeParts: Date.timeParts(decimal: true, hex: true, reverse: self.reverse), ampm: self.ampm).onTapGesture { selectedClock = .binary(decimal: true, hex: true, reverse: reverse, invert: !self.clockOrder, ampm: self.ampm) }
                }
            }
            VStack(spacing:0) {
                VStack(spacing:0) {
                    SpelledClock(timeParts: Date.timeParts(decimal: false, reverse: self.reverse), invert: !self.clockOrder).frame(width:400, height:20).onTapGesture { selectedClock = .spelled(decimal: true, hex: false, reverse: reverse, invert: !self.clockOrder, ampm: self.ampm) }

                    //                    Rectangle().frame(height: 1)
                    MorseClock(timeParts: Date.timeParts(decimal: false, reverse: self.reverse), invert: !self.clockOrder).frame(width:400, height:30).onTapGesture { selectedClock = .spelled(decimal: true, hex: false, reverse: reverse, invert: !self.clockOrder, ampm: self.ampm) }

                    //                    Rectangle().frame(height: 1)
                    BrailleClock(timeParts: Date.timeParts(decimal: false, reverse: self.reverse), invert: !self.clockOrder).frame(width:400, height:30)
                    //                    Rectangle().frame(height: 1)
                    RomanClock(timeParts: Date.timeParts(decimal: false, reverse: self.reverse), invert: !self.clockOrder).frame(width:240, height:20)
                    //                    Rectangle().frame(height: 1)
                    StickClock(timeParts: Date.timeParts(decimal: false, reverse: self.reverse), invert: !self.clockOrder).frame(width:240, height:40)
                }
                ProgressView(value: time.millisecondsToday/(24*60*60*1000)).tint(.orange).padding()
                HStack {
                    Text("\(String(format: "%.2f%%  - ", time.millisecondsToday/864000)) \(time.millisecondsToday) ").font(Font.body.monospacedDigit())
                    Text("Milliseconds").font(Font.body.monospacedDigit())
                }
                
            }
        }
        .gesture(self.gesture)
        .onTapGesture(count: 2) { self.ampm = !self.ampm }
        .onReceive(timer) { input in self.time = Date() }
        .colorScheme(self.clockOrder ? .dark : .light)
        .background(self.clockOrder ? Color.black : Color.white)
        .fullScreenCover(item: $selectedClock) { clock in
            FullScreenClockView(clockType: clock)
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
