//
//  Clock.swift
//  dcw1
//
//  Created by Benny Pollak on 7/4/20.
//  Copyright © 2020 Alben Software. All rights reserved.
//

import Foundation
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
// End clock

struct Clock: View {
    var time: TimeInterval = 10
    var decimal: Bool = true
    var lapTime: TimeInterval?
    func getOpacity(_ tick: Int) -> Double {
        if decimal {
            return tick % 50 == 0 ? 1 : 0.4
        } else {
            return tick % 20 == 0 ? 1 : 0.4
        }
    }
    func getClockFrame(_ tick: Int) -> CGSize {
        return CGSize(width: tick % 5 == 0 ? 2 : 1, height: tick % 5 == 0 ? 15 : 7)
    }
    func getDegrees(_ tick: Int) -> Double {
        if decimal {
            return Double(tick)/50 * 360
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
            ForEach(0..<(decimal ? 50 : 60)) { tick in
                self.tick(at: tick)
            }
//            if lapTime != nil {
//                Pointer()
//                    .stroke(Color.blue, lineWidth: 2)
//                    .rotationEffect(Angle.degrees(Double(lapTime!) * 360/(decimal ? 50 : 60)))
//            }
//            Pointer()
//                .stroke(Color.orange, lineWidth: 4)
//                .rotationEffect(Angle.degrees(Double(time) * 360/(decimal ? 50 : 60)))
//            Color.clear
        }
    }
}
