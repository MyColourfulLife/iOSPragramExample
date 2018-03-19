//
//  MapViewController.swift
//  WorldTroter
//
//  Created by 黄家树 on 2018/3/18.
//  Copyright © 2018年 huangjs. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    var mapView: MKMapView!
    
    override func loadView() {
        mapView = MKMapView()
        view = mapView
        let standardString = NSLocalizedString("Standard", comment: "Standard map view")
        let hybridString = NSLocalizedString("Hybrid", comment: "Hybird map view")
        let SatelliteString = NSLocalizedString("Satellite", comment: "Satellite map view")
        let segmentedControl = UISegmentedControl(items: [standardString,hybridString,SatelliteString])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(mapTypeChanged(segControl:)), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
//        let topContraint = segmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 0)
        
        let topContraint = segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8)
        
        let margins = view.layoutMarginsGuide
        
//        let leadingContraint = segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
//        let trainlingContraint = segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        
        let leadingContraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 0)
        let trainlingContraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 0)
        
        topContraint.isActive = true
        leadingContraint.isActive = true
        trainlingContraint.isActive = true

    }
    
    @objc func mapTypeChanged(segControl:UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("MapViewController load it's view.")
    }
    
    
    
    
    
}
