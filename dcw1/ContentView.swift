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
        VStack(spacing:4) {
            Text("\(timeParts.hex ? "Hex" : timeParts.decimal ? "Decimal" : "Legacy") time").font(.title)
            HStack {
                Text("\(timeParts.string)").font(.system(size: 14, design: .monospaced)).multilineTextAlignment(.leading)
                Text("\(timeParts.stringAP)").font(.system(size: 14, design: .monospaced)).multilineTextAlignment(.leading)
            }
            VStack(spacing:2) {
                Clock(timeParts: Date.timeParts(decimal: timeParts.decimal, hex: timeParts.hex))
                BinaryClock(timeParts: Date.timeParts(decimal: timeParts.decimal, hex: timeParts.hex))
                    .frame(width:100, height:100)
            }
        }
    }
}

struct ContentView: View {
    @State var time = Date()
    @State private var clockOrder = true
    @State private var hex = true
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
            if abs(w) > 100 {
                self.hex = !self.hex
//                self.clockOrder = !self.clockOrder
            }
        }
    }
    var body: some View {
        
        VStack(spacing:3) {
            VStack(spacing:4) {
                AClocks(timeParts: Date.timeParts(decimal: true, hex: self.hex))
            }
            Divider()
            VStack(spacing:4) {
                AClocks(timeParts: Date.timeParts(decimal: false))
            }
            
            Divider()
            VStack(spacing:4) {
                Text("Milliseconds").font(.title)
                Text("\(time.millisecondsToday)").font(Font.body.monospacedDigit())
            }
            Spacer()
            
        }.gesture(self.gesture)
        .onReceive(timer) { input in
//            let formatter = DateFormatter()
//            formatter.dateFormat = "HH:mm:ss"
//            self.regularTime = formatter.string(from: Date())
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
            ContentView()
        }
    }
}
