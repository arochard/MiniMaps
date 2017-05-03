//
//  FirstViewController.swift
//  D05
//
//  Created by Alexandre ROCHARD on 4/10/17.
//  Copyright © 2017 Alexandre ROCHARD. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class FirstViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    let annotation = MKPointAnnotation()
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        if (CLLocationManager.locationServicesEnabled())
        {
            print("I'am here !!")
            locationManager.requestWhenInUseAuthorization()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.distanceFilter = 10
        }
        SharedData.sharedInstance.addAllPin(map: self.mapView)
        self.setLocation(id: 0)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! as CLLocation
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.mapView.setRegion(region, animated: true)
        
        //Drop pin on user location
        let anno = MKPointAnnotation()
        anno.coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        anno.title = "Current location"
        mapView.addAnnotation(anno)
    }


    @IBAction func changeMap(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        case 2:
            mapView.mapType = .hybrid
        default:
            mapView.mapType = .standard
            
        }
    }
    @IBAction func geoButton(_ sender: UIButton) {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    func setLocation(id: Int) {
        let viewRegion = MKCoordinateRegionMakeWithDistance(SharedData.sharedInstance.places[id].location, 300, 300)
        mapView.setRegion(viewRegion, animated: false)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation
        {
            return nil
        }
        let id = "pin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: id) as? MKPinAnnotationView
        if (annotationView == nil){
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: id)
            annotationView?.canShowCallout = true
            annotationView?.animatesDrop = true
            
        }else{
            annotationView?.annotation = annotation
        }
        if let annotation = annotation as? ColorPointAnnotation {
            annotationView?.pinTintColor = annotation.pinColor
            annotationView?.canShowCallout = true
            annotationView?.animatesDrop = true
        }
        
        return annotationView
        
    }
}

