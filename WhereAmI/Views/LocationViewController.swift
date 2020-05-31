//
//  LocationViewController.swift
//  WhereAmI
//
//  Created by Aldo Corona on 29/05/20.
//  Copyright © 2020 IMOX. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class LocationViewController: ViewController, LocationViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var name: String = ""
    var idDevice: String = ""
    let locationPresenter = LocationPresenter()
    
    override func viewDidLoad() {
        locationPresenter.setViewDelegate(locationView: self)
        locationPresenter.getLocation(idDevice: idDevice)
    }
    
    func setLocation(location: LocationModel) {
        print(location.latitude)
        print(location.longitude)
        DispatchQueue.main.async {
            let centeredlocation = CLLocation(latitude: Double(location.latitude)!, longitude: Double(location.longitude)!)
            self.mapView.centerToLocation(centeredlocation)
            let artwork: Artwork = Artwork(title: self.name, locationName: self.name, discipline: "location", coordinate: CLLocationCoordinate2D(latitude: Double(location.latitude)!, longitude: Double(location.longitude)!))
            self.mapView.addAnnotation(artwork)
        }
    }
}

private extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 1000
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}

protocol LocationViewDelegate {
    func setLocation(location: LocationModel)
}
