//
//  ContentView.swift
//  dcw1
//
//  Created by Benny Pollak on 6/20/20.
//  Copyright © 2020 Alben Software. All rights reserved.
//

import SwiftUI
extension Date {
    func toMillis() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
    var startOfNextDay: Date {
        return Calendar.current.nextDate(after: self, matching: DateComponents(hour: 0, minute: 0), matchingPolicy: .nextTimePreservingSmallerComponents)!
    }
    var millisecondsToday: TimeInterval {
        return (24*60*60-startOfNextDay.timeIntervalSince(self)) * 1000
    }
    var millisecondsUntilTheNextDay: TimeInterval {
        return startOfNextDay.timeIntervalSinceNow
    }
}
struct ContentView: View {
    @State var currentDate = Date()
    @State var regularTime = "regularTime"
    @State var time = "time"
    @State var decimalTime = "decimalTime"
    @State var decimalTimeAP = "decimalTimeAP"
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text("Decimal clock").font(.largeTitle)
            Spacer()
            Group {
            Text("Regular time").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            Text("\(regularTime)").font(Font.body.monospacedDigit())
            }
            Spacer()
            VStack (alignment: .leading) {

            Text("Decimal time").font(.title)
            Text("\(decimalTime)").font(Font.body.monospacedDigit()).multilineTextAlignment(.leading)
            Text("\(decimalTimeAP)").font(Font.body.monospacedDigit()).multilineTextAlignment(.leading)
            }
            Spacer()
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
            
            let millisecs = Date().millisecondsToday
            let timeFraction = millisecs/86424000
            
            // Calculate decimal time
            var dhour = Int(floor(timeFraction*100))
            let dmins = Int(abs(timeFraction*100-floor(timeFraction*100))*100)
            let dsecs = Int(abs(timeFraction*10000-floor(timeFraction*10000))*100)
            let decimalTimeString = String(format:"%02d:%02d:%02d", dhour, dmins, dsecs)
            self.decimalTime = "\(decimalTimeString)"
            var ampm = "AM"
            if dhour >= 50 {
                ampm = "PM"
                dhour -= 50
            }
            let decimalTimeStringAP = String(format:"%02d:%02d:%02d %@", dhour, dmins, dsecs, ampm)
            self.decimalTimeAP = "\(decimalTimeStringAP)"
            
            let timeString = String(format:"%6.10f",timeFraction*100000)
            self.time = "\(timeString)"
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
