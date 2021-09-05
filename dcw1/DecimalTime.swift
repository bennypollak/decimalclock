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
    var hex: Bool
    var reverse: Bool
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
    static func parts(decimal: Bool, hour: Double, mins: Double, secs: Double, fraction:Double, hex: Bool = false, reverse: Bool = false) -> TimeParts {
        let timeString = String(format:hex ? "%02X:%02X:%02X" : "%02d:%02d:%02d", Int(hour), Int(mins), Int(secs))
        var hours = hour
        var ampm = "AM"
        if hours >= (hex ? 128 : decimal ? 50 : 12) {
            ampm = "PM"
            hours -= (hex ? 128 : decimal ? 50 : 12)
        }
        let timeStringAP = String(format:hex ? "%02X:%02X:%02X %@" : "%02d:%02d:%02d %@", Int(hours), Int(mins), Int(secs), ampm)
        let timeParts = TimeParts(decimal: decimal, hex: hex, reverse: reverse, hours: hour, mins: mins, secs: secs, fraction:fraction, string: timeString, stringAP: timeStringAP)
        return timeParts
    }
    static func timeParts(decimal: Bool = true, date: Date = Date(), hex: Bool = false, reverse: Bool = true) -> TimeParts {
        var millisecs = date.millisecondsToday
        if reverse {
            millisecs = 24*60*60*1000 - millisecs
        }
        var mode: Double = 0.0
        if hex  {
            // ff:ff:ff
            mode = 24*60*60*1000/256
        } else if decimal {
            mode = 24*60*60*1000/100
        } else {
            mode = 100*60*60*1000/100
        }
        let div: Double = hex ? 256 : decimal ? 100 : 60
        let timeFraction = millisecs/mode
        
        // Calculate decimal time
        let dhour = timeFraction
        let dmins = (dhour-floor(dhour))*div
        let dsecs = (dmins-floor(dmins))*div
        let dfract = (dsecs-floor(dsecs))
        return parts(decimal: decimal, hour: dhour, mins: dmins, secs: dsecs, fraction:dfract, hex: hex, reverse: reverse)
    }
}
