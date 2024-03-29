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
    var body: some View {
        VStack(spacing:2) {
            HStack {
//                Text("\(timeParts.hex ? "Hex" : timeParts.decimal ? "Decimal" : "Standard") time")
                Text(timeParts.hex ? "Hex time" : timeParts.decimal ? "Decimal time" : "Standard time").font(.system(size: 14, design: .monospaced)).multilineTextAlignment(.leading)
                Text("\(timeParts.string)").font(.system(size: 14, design: .monospaced)).multilineTextAlignment(.leading)
                Text("\(timeParts.stringAP)").font(.system(size: 14, design: .monospaced)).multilineTextAlignment(.leading)
            }
            VStack(spacing:2) {
                Clock(timeParts: Date.timeParts(decimal: timeParts.decimal, hex: timeParts.hex, reverse: timeParts.reverse))
                BinaryClock(timeParts: Date.timeParts(decimal: timeParts.decimal, hex: timeParts.hex, reverse: timeParts.reverse))
                    .frame(width:100, height:100)
            }
        }
    }
}

struct ContentView: View {
    @State var time = Date()
    @State private var clockOrder = true
    @State private var hex = true
    @State private var reverse = false
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
        
        VStack(spacing:1) {
            VStack(spacing:2) {
                Text("")
                AClocks(timeParts: Date.timeParts(decimal: true, hex: self.hex, reverse: self.reverse))
//            }
//            Divider()
//            VStack(spacing:1) {
                AClocks(timeParts: Date.timeParts(decimal: false, reverse: self.reverse))
            }

            Divider()
           VStack(spacing:1) {
               SpelledClock(timeParts: Date.timeParts(decimal: false, reverse: self.reverse), invert: !self.clockOrder).frame(width:400, height:60)
               RomanClock(timeParts: Date.timeParts(decimal: false, reverse: self.reverse), invert: !self.clockOrder).frame(width:240, height:30)
               StickClock(timeParts: Date.timeParts(decimal: false, reverse: self.reverse), invert: !self.clockOrder).frame(width:240, height:60)
               ProgressView(value: time.millisecondsToday/(24*60*60*1000)){
                   HStack {
                       Text("\(String(format: "%.2f%%  - ", time.millisecondsToday/(24*60*60*1000) * 100))").monospacedDigit()
                       Text("\(time.millisecondsToday) ").font(Font.body.monospacedDigit())
                       Text("Milliseconds").font(Font.body.monospacedDigit())
                   }
               }.tint(.orange).padding()
//            LocationView()
            }
            Spacer()
            
        }.gesture(self.gesture)
        .onTapGesture(count: 2) {
            self.hex = !self.hex
        }

        .onReceive(timer) { input in
            self.time = Date()
        }
        .colorScheme(self.clockOrder ? .dark : .light)
        .background(self.clockOrder ? Color.black : Color.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
