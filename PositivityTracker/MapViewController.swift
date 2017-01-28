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
    var entry: JournalEntry?
    var annotationDictionary: [String:Any] = [:]
    var annotationsArray: [[String:Any]] = []
    var points: [MKPointAnnotation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadAnnotations()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !annotationsArray.isEmpty {
            for annotation in annotationsArray {
                let makeAnnotation: MKPointAnnotation = MKPointAnnotation()
                makeAnnotation.coordinate = CLLocationCoordinate2DMake(annotation["latitude"] as! CLLocationDegrees, annotation["longitude"] as! CLLocationDegrees)
                makeAnnotation.title = annotation["message"] as? String
                mapView.addAnnotation(makeAnnotation)
            }
        }
        displayMap()
    }
        
    func displayMap() {
        if (entry != nil) {
            let center = CLLocationCoordinate2D(latitude: (entry?.lat)!, longitude: (entry?.long)!)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            mapView.setRegion(region, animated: true)
            
            // Drop a pin at user's Current Location
            let myAnnotation: MKPointAnnotation = MKPointAnnotation()
            myAnnotation.coordinate = CLLocationCoordinate2DMake((entry?.lat)!, (entry?.long)!)
            myAnnotation.title = entry?.message
            mapView.addAnnotation(myAnnotation)
            saveAnnotations()
        }
        else {
            /*
            // Drop a pin at user's Current Location
            let myAnnotation: MKPointAnnotation = MKPointAnnotation()
            myAnnotation.coordinate = CLLocationCoordinate2DMake(44, -93);
            myAnnotation.title = "Current Location"
            mapView.addAnnotation(myAnnotation)
            */
            mapView.showAnnotations(points, animated: true)
        }
    }
    
    //MARK: Saving and Loading Annotations
    
    func saveAnnotations() {
        if (entry != nil) {
            annotationDictionary["latitude"] = entry?.lat
            annotationDictionary["longitude"] = entry?.long
            annotationDictionary["message"] = entry?.message
            if let annotations = UserDefaults.standard.object(forKey: "annotationPins") {
                annotationsArray = annotations as! [[String : Any]]
            }
            annotationsArray.append(annotationDictionary)
            UserDefaults.standard.set(annotationsArray, forKey: "annotationPins")
            UserDefaults.standard.synchronize()
        }
    }
    
    func loadAnnotations() {
        if let locations = UserDefaults.standard.object(forKey: "annotationPins") {
            for dict in locations as! [AnyObject]{
                annotationsArray.append(dict as! [String:Any])
            }
            for a in annotationsArray {
                let makeAnno: MKPointAnnotation = MKPointAnnotation()
                makeAnno.coordinate = CLLocationCoordinate2DMake(a["latitude"] as! CLLocationDegrees, a["longitude"] as! CLLocationDegrees)
                makeAnno.title = a["message"] as! String?
                points.append(makeAnno)
            }
        }
    }

    func removeAllStoredAnnotations(){
        UserDefaults.standard.removeObject(forKey: "annotationPins")
        UserDefaults.standard.synchronize()
    }
    
    //MAKR: Segment Control
    @IBAction func mapTypeControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        default:
            mapView.mapType = .standard
        }
    }
    @IBAction func resetPins(_ sender: UIButton) {
        removeAllStoredAnnotations()
        _ = navigationController?.popToRootViewController(animated: true)
    }
}
