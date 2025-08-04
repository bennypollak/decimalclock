//
//  FullScreenClockView.swift
//  dcw1
//
//  Created by Benny Pollak on 7/31/25.
//  Copyright © 2025 Alben Software. All rights reserved.
//

import SwiftUI

struct FullScreenClockView: View {
    let clockType: ClockType

    @State private var time = Date()
    private let timer = Timer.publish(every: 0.001, on: .main, in: .common).autoconnect()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        let (decimal, hex, reverse, invert, ampm) = clockType.settings
        let timeParts = Date.timeParts(decimal: decimal, hex: hex, reverse: reverse)

        return ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                Button("Close") { dismiss() }.padding()
                    .foregroundColor(.white)
                Spacer()

                Group {
                    switch clockType {
                    case .binary:
                        BinaryClock(timeParts: timeParts, ampm: ampm)
                    case .spelled:
                        SpelledClock(timeParts: timeParts, invert: invert)
                    case .morse:
                        MorseClock(timeParts: timeParts, invert: invert)
                    case .braille:
                        BrailleClock(timeParts: timeParts, invert: invert)
                    case .roman:
                        RomanClock(timeParts: timeParts, invert: invert)
                    case .stick:
                        StickClock(timeParts: timeParts, invert: invert)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
                Spacer()
            }
        }
        .onReceive(timer) { input in self.time = Date() }
    }
}

struct FullScreenClockView_Previews: PreviewProvider {
    static var previews: some View {
        let binaryClockType: ClockType = .binary(decimal: true, hex: false, reverse: false, invert: false, ampm: true)

        return Group {
            FullScreenClockView(clockType: binaryClockType)
                .previewDisplayName("Binary Clock")

        }
    }
}
