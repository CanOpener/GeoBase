//
//  ViewController.swift
//  GeoBase
//
//  Created by Mladen Kajic on 03/07/2016.
//  Copyright © 2016 Mladen Kajic. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class HubVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    
    @IBOutlet var longitudeLabel: UILabel!
    @IBOutlet var latitudeLabel: UILabel!
    @IBOutlet var altitudeLabel: UILabel!
    @IBOutlet var directionLabel: UILabel!
    
    @IBOutlet var mapView: MKMapView!
    
    var set = false
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
        self.locationManager.startUpdatingHeading()
        self.mapView.showsUserLocation = true
        self.mapView.showsCompass = true
        self.mapView.setUserTrackingMode(MKUserTrackingMode.FollowWithHeading, animated: true)
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                                            longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        
        self.latitudeLabel.text = " Latitude\n  \(center.latitude)"
        self.longitudeLabel.text = " Longitude\n  \(center.longitude)"
        self.altitudeLabel.text = " Altitude\n  \(location.altitude)M"
        if !set {
            self.mapView.setRegion(region, animated: true)
        }
        set = true
        
        //self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateHeading newHeading: CLHeading!) {
        self.directionLabel.text = "Direction\n\(newHeading.magneticHeading)"
        //self.locationManager.stopUpdatingHeading()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Location Error: \(error.localizedDescription)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

