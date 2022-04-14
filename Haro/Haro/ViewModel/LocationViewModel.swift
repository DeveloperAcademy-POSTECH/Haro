//
//  LocationViewModel.swift
//  Haro
//
//  Created by Shin Jae Ung on 2022/04/13.
//

import SwiftUI
import CoreLocation

class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    @Published var region: String = "알 수 없음"
    
    override init() {
        super.init()
        self.manager.delegate = self
        self.manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.manager.stopUpdatingLocation()
        guard let location2D = locations.first?.coordinate else { return }
        let location = CLLocation(latitude: location2D.latitude, longitude: location2D.longitude)
        CLGeocoder().reverseGeocodeLocation(location) { placeMark, error in
            guard error == nil else { return }
            if let administrativeArea = placeMark?.first?.administrativeArea {
                self.region = administrativeArea
                if let locality = placeMark?.first?.locality {
                    self.region += " " + locality
                    if let subLocality = placeMark?.first?.subLocality {
                        self.region += " " + subLocality
                    }
                }
            } else {
                self.region = "알 수 없음"
            }
        }
    }
}
