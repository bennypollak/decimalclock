//
//  ContentView.swift
//  dcw1
//
//  Created by Benny Pollak on 6/20/20.
//  Copyright © 2020 Alben Software. All rights reserved.
//

import SwiftUI

// Clock https://talk.objc.io/episodes/S01E192-analog-clock
extension CGRect {
    var center: CGPoint {
        CGPoint(x: midX, y: midY)
    }
    
    init(center: CGPoint, radius: CGFloat) {
        self = CGRect(
            x: center.x - radius,
            y: center.y - radius,
            width: radius * 2,
            height: radius * 2
        )
    }
}
struct Pointer: Shape {
    var circleRadius: CGFloat = 3
    func path(in rect: CGRect) -> Path {
        Path { p in
            p.move(to: CGPoint(x: rect.midX, y: rect.minY))
            p.addLine(to: CGPoint(x: rect.midX, y: rect.midY - circleRadius))
            p.addEllipse(in: CGRect(center: rect.center, radius: circleRadius))
            p.move(to: CGPoint(x: rect.midX, y: rect.midY + circleRadius))
            p.addLine(to: CGPoint(x: rect.midX, y: rect.midY + rect.height / 10))
        }
    }
}
struct Clock: View {
    var time: TimeInterval = 10
    var lapTime: TimeInterval?
    
    func tick(at tick: Int) -> some View {
        VStack {
            Rectangle()
                .fill(Color.primary)
                .opacity(tick % 50 == 0 ? 1 : 0.4)
//                .frame(width: 2, height: tick % 4 == 0 ? 15 : 7)
                .frame(width: 1, height: tick % 5 == 0 ? 15 : 7)
            Spacer()
        }
//        .rotationEffect(Angle.degrees(Double(tick)/240 * 360))
        .rotationEffect(Angle.degrees(Double(tick)/500 * 360))
    }
    
    
    var body: some View {
        ZStack {
//            ForEach(0..<60*4) { tick in
            ForEach(0..<50*10) { tick in
                self.tick(at: tick)
            }
            if lapTime != nil {
                Pointer()
                    .stroke(Color.blue, lineWidth: 2)
                    .rotationEffect(Angle.degrees(Double(lapTime!) * 360/50))
            }
            Pointer()
                .stroke(Color.orange, lineWidth: 4)
                .rotationEffect(Angle.degrees(Double(time) * 360/50))
            Color.clear
        }
    }
}
// End clock

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
struct ContentView1: View {
//    @ObservedObject var stopwatch = StopwatchModel()
    
    var body: some View {
        VStack {
            Clock(time: Date().millisecondsToday).frame(width: 300, height: 300, alignment: .center)
            //Text(stopwatch.total.formatted)
            //    .font(Font.system(size: 64, weight: .thin).monospacedDigit())
            // ...
        }
    }
}
struct ContentView: View {
    @State var currentDate = Date()
    @State var regularTime = "regularTime"
    @State var time = "time"
    @State var decimalTime = "decimalTime"
    @State var decimalTimeAP = "decimalTimeAP"
    //    @ObservedObject var stopwatch = StopwatchModel()
    let timer = Timer.publish(every: 0.001, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Group {
                Text("Decimal clock").font(.largeTitle)
                Spacer()
                //                Clock(time: stopwatch.total, lapTime: stopwatch.laps.last?.0)
                Clock(time: Date().millisecondsToday, lapTime: Date().millisecondsToday+2000).frame(width: 300, height: 300, alignment: .center)
                Text("Regular time").font(.title  )
                Text("\(regularTime)").font(Font.body.monospacedDigit())
                Spacer()
            }
            VStack (alignment: .leading) {
                
                Text("Decimal time").font(.title)
                Text("\(decimalTime)").font(Font.body.monospacedDigit()).multilineTextAlignment(.leading)
                Text("\(decimalTimeAP)").font(Font.body.monospacedDigit()).multilineTextAlignment(.leading)
            }
            
//            Spacer()
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
            
            let timeString = String(format:"%6.10f",millisecs/1000)
            self.time = "\(timeString)"
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
