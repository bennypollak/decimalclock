//
//  DecimalTime.swift
//  dcw1
//
//  Created by Benny Pollak on 7/3/20.
//  Copyright © 2020 Alben Software. All rights reserved.
//

import Foundation
struct TimeParts {
    var decimal: Bool
    var hours: Double
    var mins: Double
    var secs: Double
    var fraction: Double
    var string: String
    var stringAP: String
}

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
    static func parts(decimal: Bool, hour: Double, mins: Double, secs: Double, fraction:Double) -> TimeParts {
        let timeString = String(format:"%02d:%02d:%02d", Int(hour), Int(mins), Int(secs))
        var hours = hour
        var ampm = "AM"
        if hours >= (decimal ? 50 : 12) {
            ampm = "PM"
            hours -= (decimal ? 50 : 12)
        }
        let timeStringAP = String(format:"%02d:%02d:%02d %@", Int(hours), Int(mins), Int(secs), ampm)
        let timeParts = TimeParts(decimal: decimal, hours: hour, mins: mins, secs: secs, fraction:fraction, string: timeString, stringAP: timeStringAP)
        return timeParts
    }
    static func timeParts(decimal: Bool = true, date: Date = Date()) -> TimeParts {
        let millisecs = date.millisecondsToday

        let mode: Double = decimal ? 24*60*60*1000 : 100000*60*60
        let div: Double = decimal ? 100 : 60
        let timeFraction = millisecs/mode
        
        // Calculate decimal time
        let dhour = timeFraction*100
        let dmins = (dhour-floor(dhour))*div
        let dsecs = (dmins-floor(dmins))*div
        let dfract = (dsecs-floor(dsecs))
        return parts(decimal: decimal, hour: dhour, mins: dmins, secs: dsecs, fraction:dfract)
    }
}
