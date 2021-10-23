////
////  LocationView.swift
////  dcw1
////
////  Created by Benny Pollak on 10/9/21.
////  Copyright © 2021 Alben Software. All rights reserved.
////
//
//import Foundation
//import SwiftUI
//
//struct LocationView: View {
//    @ObservedObject var location = LocationManager()
//
//    var lat: String {
//        return "\(location.lastKnownLocation?.location.coordinate.latitude ?? 0.0)"
//    }
//
//    var lon: String {
//        return "\(location.lastKnownLocation?.location.coordinate.longitude ?? 0.0)"
//    }
//    var riseset: String {
//        return "\(location.lastKnownLocation?.sunrise ?? "")\(location.lastKnownLocation?.sunset ?? "")"
//    }
//
//    init() {
////        self.location.startUpdating()
//    }
//
//    var body: some View {
//        VStack {
//            Text("Latitude: \(lat) Longitude: \(lon) rset: \(riseset)")
//        }
//    }
//}
//struct LocationView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            LocationView()
//        }
//    }
//}
