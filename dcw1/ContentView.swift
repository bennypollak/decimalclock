//
//  ContentView.swift
//  dcw1
//
//  Created by Benny Pollak on 6/20/20.
//  Copyright © 2020 Alben Software. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    @State var currentDate = Date()
    @State var regularTime = "regularTime"
    @State var regularTimeAP = "regularTimeAP"
    @State var time = "time"
    @State var decimalTime = "decimalTime"
    @State var decimalTimeAP = "decimalTimeAP"
    let timer = Timer.publish(every: 0.001, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            VStack {
                Text("Decimal time").font(.title)
                HStack {
                Text("\(decimalTime)").font(Font.body.monospacedDigit()).multilineTextAlignment(.leading)
                Text("\(decimalTimeAP)").font(Font.body.monospacedDigit()).multilineTextAlignment(.leading)
                }
                Clock(time: Date.timeParts(decimal: true), decimal: true)
                Spacer()
            }
            VStack (alignment: .center) {
                Text("Legacy time").font(.title  )
                HStack {
                Text("\(regularTime)").font(Font.body.monospacedDigit())
                Text("\(regularTimeAP)").font(Font.body.monospacedDigit())
                }
                Clock(time: Date.timeParts(decimal: false), decimal: false)
                Spacer()
            }
            
            VStack {
                Text("Seconds").font(.title)
                Text("\(time)").font(Font.body.monospacedDigit())
            }
            Spacer()
            
        }
        .onReceive(timer) { input in
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm:ss"
            self.regularTime = formatter.string(from: Date())
            formatter.dateFormat = "hh:mm:ss a"
            self.regularTimeAP = formatter.string(from: Date())

            var dtime = Date.timeParts(decimal: true)
            let decimalTimeString = String(format:"%02d:%02d:%02d", Int(dtime.hours), Int(dtime.mins), Int(dtime.secs))
            self.decimalTime = "\(decimalTimeString)"
            var ampm = "AM"
            if dtime.hours >= 50 {
                ampm = "PM"
                dtime.hours -= 50
            }
            let decimalTimeStringAP = String(format:"%02d:%02d:%02d %@", Int(dtime.hours), Int(dtime.mins), Int(dtime.secs), ampm)
            self.decimalTimeAP = "\(decimalTimeStringAP)"
            let timeString = String(format:"%6.10f",Date().millisecondsToday/1000)
            self.time = "\(timeString)"
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
