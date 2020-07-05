//
//  Clock.swift
//  dcw1
//
//  Created by Benny Pollak on 7/4/20.
//  Copyright © 2020 Alben Software. All rights reserved.
//

import Foundation
import SwiftUI
// https://stackoverflow.com/questions/58411990/how-to-make-a-swipeable-view-with-swiftui
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
    var fraction: CGFloat = 0.0
    var extention: CGFloat = 10.0
    func path(in rect: CGRect) -> Path {
        Path { p in
            p.move(to: CGPoint(x: rect.midX, y: rect.minY - (circleRadius-fraction)))
            p.addLine(to: CGPoint(x: rect.midX, y: rect.midY))
            p.addEllipse(in: CGRect(center: rect.center, radius: circleRadius))
            p.move(to: CGPoint(x: rect.midX, y: rect.midY + circleRadius-extention))
            p.addLine(to: CGPoint(x: rect.midX, y: rect.midY + rect.height / 10))
        }
    }
}
// End clock

struct Clock: View {
    var time: TimeParts?
    var decimal: Bool = true
    func getOpacity(_ tick: Int) -> Double {
        return 1
        if decimal {
            return tick % 100 == 0 ? 1 : 0.4
        } else {
            return tick % 20 == 0 ? 1 : 0.4
        }
    }
    func getClockFrame(_ tick: Int) -> CGSize {
        if decimal {
            return CGSize(width: tick % 10 == 0 ? 2 : 1, height: tick % 10 == 0 ? 15 : 7)
        } else {
            return CGSize(width: tick % 5 == 0 ? 2 : 1, height: tick % 5 == 0 ? 15 : 7)        }
    }
    func getDegrees(_ tick: Int) -> Double {
        if decimal {
            return Double(tick)/100 * 360
        } else {
            return Double(tick)/60 * 360
        }
    }
    func tick(at tick: Int) -> some View {
        return VStack {
            Rectangle()
                .fill(Color.primary)
                .opacity(getOpacity(tick))
                .frame(width: getClockFrame(tick).width, height: getClockFrame(tick).height)
            
            Spacer()
        }
        .rotationEffect(Angle.degrees(getDegrees(tick)))
    }
    
    
    var body: some View {
        ZStack {
            ForEach(0..<(decimal ? 100 : 60)) { tick in
                self.tick(at: tick)
            }
            Pointer(fraction:10)
                .stroke(Color.primary, lineWidth: 1)
                .rotationEffect(Angle.degrees(floor(time!.secs) * 360/(decimal ? 100 : 60)))
            Color.clear
            Pointer(fraction: 10)
                .stroke(Color.primary, lineWidth: 4)
                .rotationEffect(Angle.degrees(360*time!.mins/(decimal ? 100 : 60)))
            Pointer(fraction:50)
                .stroke(Color.primary, lineWidth: 4)
                .rotationEffect(Angle.degrees(360*time!.hours/(decimal ? 100 : 12)))
            Color.clear
        }
        
    }
}

struct ContentView_PreviewsClock: PreviewProvider {
    static var previews: some View {
        GeometryReader{g in
            VStack {
                Clock(time: Date.timeParts(decimal: true), decimal: true)
                    .frame(width: min(g.size.width,g.size.width), height: min(g.size.width,g.size.width), alignment: Alignment.center)
            }
        }
        
    }
}
