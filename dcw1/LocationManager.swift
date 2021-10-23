////
////  LocationManager.swift
////  dcw1
////
////  Created by Benny Pollak on 10/9/21.
////  Copyright © 2021 Alben Software. All rights reserved.
////
//
//import Foundation
//import CoreLocation
//// https://timezonedb.com/references/get-time-zone
//// http://api.timezonedb.com/v2.1/get-time-zone?key=E3W3HMRZKCJ4&format=json&by=position&lat=40.689247&lng=-74.044502
//// https://api.sunrise-sunset.org/json?lat=36.7201600&lng=-4.4203400
//// {"results":{"sunrise":"6:18:43 AM","sunset":"5:51:02 PM","solar_noon":"12:04:52 PM","day_length":"11:32:19","civil_twilight_begin":"5:54:09 AM","civil_twilight_end":"6:15:35 PM","nautical_twilight_begin":"5:24:12 AM","nautical_twilight_end":"6:45:33 PM","astronomical_twilight_begin":"4:54:12 AM","astronomical_twilight_end":"7:15:33 PM"},"status":"OK"}
//struct LocationParts {
//    var location: CLLocation
//    var sunrise: String
//    var sunset: String
//}
//
//class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
//    private let manager = CLLocationManager()
//    @Published var lastKnownLocation: LocationParts?
//    
//    func startUpdating() {
//        self.manager.delegate = self
//        self.manager.requestWhenInUseAuthorization()
//        self.manager.startUpdatingLocation()
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        lastKnownLocation = LocationParts(location: locations.last!, sunrise: "rise", sunset: "set")
////        self.manager.stopUpdatingLocation()
//    }
//    
//}
