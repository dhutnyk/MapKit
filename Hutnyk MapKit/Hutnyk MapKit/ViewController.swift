//
//  ViewController.swift
//  Hutnyk MapKit
//
//  Created by period4 on 5/25/21.
//  Copyright © 2021 period4. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class ViewController: UIViewController, UISearchBarDelegate, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var mapKit: MKMapView!
    
    let locationManager = CLLocationManager()
    
    var MPCoordinates = CLLocationCoordinate2D(latitude: 42.066418, longitude: -87.937294)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapKit.mapType = .satelliteFlyover
        mapKit.showsUserLocation = true
        mapKit.showsCompass = true
        mapKit.showsTraffic = true
        mapKit.showsBuildings = true
        mapKit.centerCoordinate = MPCoordinates
        checkLocationServices()
        
    }
   
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         guard let location = locations.last else { return }
         let region = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: 4000, longitudinalMeters: 4000)
         mapKit.setRegion(region, animated: true)
     }
    
     func checkLocationAuthorization() {
         switch CLLocationManager.authorizationStatus() {
         case .authorizedWhenInUse:
             mapKit.showsUserLocation = true
             followUserLocation()
             locationManager.startUpdatingLocation()
             break
         case .denied:
             // Show alert
             break
         case .notDetermined:
             locationManager.requestWhenInUseAuthorization()
         case .restricted:
             // Show alert
             break
         case .authorizedAlways:
             break
         }
     }
     
     func checkLocationServices() {
         if CLLocationManager.locationServicesEnabled() {
             setupLocationManager()
             checkLocationAuthorization()
         } else {
             // the user didn't turn it on
         }
     }
     
     func followUserLocation() {
         if let location = locationManager.location?.coordinate {
             let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 4000, longitudinalMeters: 4000)
             mapKit.setRegion(region, animated: true)
         }
     }
     
     func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
         checkLocationAuthorization()
     }
     
     func setupLocationManager() {
         locationManager.delegate = self
         locationManager.desiredAccuracy = kCLLocationAccuracyBest
     }

}

