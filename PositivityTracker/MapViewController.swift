//
//  MapViewController.swift
//  PositivityTracker
//
//  Created by Kevin Tang on 1/20/17.
//  Copyright © 2017 Kevin Tang. All rights reserved.
//

import UIKit
import MapKit
import os

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    //MARK: Properties
    @IBOutlet var mapView: MKMapView!
    var locationDictionary: [String: Double] = [:]
    var locationArray: [[String:Double]] = []
    var lat: Double?
    var long: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLocations()
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if locationArray.count != 0 {
            for dict in locationArray{
                let annotation: MKPointAnnotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2DMake(dict["latitude"]!, dict["longitude"]!)
                annotation.title = "One of your locations"
                mapView.addAnnotation(annotation)
            }
        }
        if (lat != nil) {
            let center = CLLocationCoordinate2D(latitude: lat!, longitude: long!)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            mapView.setRegion(region, animated: true)
            
            // Drop a pin at user's Current Location
            let myAnnotation: MKPointAnnotation = MKPointAnnotation()
            myAnnotation.coordinate = CLLocationCoordinate2DMake(lat!, long!);
            myAnnotation.title = "Current location"
            mapView.addAnnotation(myAnnotation)
            saveLocations()
        }
        
        if (lat == nil) {
            let center = CLLocationCoordinate2D(latitude: 44.9398, longitude: -93.1687)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            mapView.setRegion(region, animated: true)
            
            // Drop a pin at user's Current Location
            let myAnnotation: MKPointAnnotation = MKPointAnnotation()
            myAnnotation.coordinate = CLLocationCoordinate2DMake(44.9398, -93.1687);
            myAnnotation.title = "Current location"
            mapView.addAnnotation(myAnnotation)
        }
    }
    
    //MARK: Methods
    func saveLocations() {
        if !(lat?.isZero)! || !(long?.isZero)! {
            locationDictionary["latitude"] = lat
            locationDictionary["longitude"] = long
            if UserDefaults.standard.object(forKey: "locationArray") != nil {
                locationArray = UserDefaults.standard.object(forKey: "locationArray") as! [[String:Double]]
                }
            locationArray.append(locationDictionary)
            UserDefaults.standard.set(locationArray, forKey: "locationArray")
            UserDefaults.standard.synchronize()
        }
    }

    func loadLocations() {
        if UserDefaults.standard.object(forKey: "locationArray") != nil {
            for dict in UserDefaults.standard.object(forKey: "locationArray") as! [[String:Double]]{
                locationArray.append(dict)
            }
        }
    }
}


