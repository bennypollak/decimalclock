//
//  Stopwatch.swift
//  dcw1
//
//  Created by Benny Pollak on 6/28/20.
//  Copyright © 2020 Alben Software. All rights reserved.
//

import Foundation
struct StopwatchData {
    var absoluteStartTime: TimeInterval?
    var currentTime: TimeInterval = 0
    var additionalTime: TimeInterval = 0
    
    var totalTime: TimeInterval {
        guard let start = absoluteStartTime else { return 0 }
        return currentTime - start
    }
}


