//
//  Place.swift
//  D05
//
//  Created by Alexandre ROCHARD on 4/10/17.
//  Copyright © 2017 Alexandre ROCHARD. All rights reserved.
//

import Foundation
import MapKit

struct Place {
    let name: String
    let latitude: Double
    let longitude: Double
    let desc: String
    var annotation = ColorPointAnnotation()
    var location = CLLocationCoordinate2D()
    
    init(name: String, lat: Double, long: Double, desc: String, color: UIColor) {
        self.name = name
        self.latitude = lat
        self.longitude = long
        self.desc = desc
        self.annotation.pinColor = color
        self.annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        self.annotation.title = name
        self.annotation.subtitle = desc
        self.location.latitude = lat
        self.location.longitude = long
    }
}

class SharedData{
    var places: [Place] = []
    
    init() {
        self.places.append(Place(name: "42", lat: 48.896540, long: 2.318484, desc: "This is a school... yeah, I know... :/", color: UIColor.blue))
        self.places.append(Place(name: "Bastille", lat: 48.853155, long: 2.369161, desc: "Good place for drink !!", color: UIColor.red))
        self.places.append(Place(name: "Sydney Opera", lat: -33.856648, long: 151.215312, desc: "Just an opera...", color: UIColor.green))
        self.places.append(Place(name: "Golden Gate Bridge", lat: 37.819217, long: -122.478464, desc: "For Apes.", color: UIColor.darkGray))
    }
    
    func addAllPin(map: MKMapView){
        for p in places
        {
            map.addAnnotation(p.annotation)
        }
    }
    
    static let sharedInstance = SharedData()
}

class ColorPointAnnotation: MKPointAnnotation {
    var pinColor: UIColor?
}
