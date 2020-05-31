//
//  LocationPresenter.swift
//  WhereAmI
//
//  Created by Aldo Corona on 29/05/20.
//  Copyright © 2020 IMOX. All rights reserved.
//

import Foundation

class LocationPresenter {
    var locationInteractor: LocationInteractor?
    var locationDelegate: LocationViewDelegate?
    
    init(){
        locationInteractor = LocationInteractor()
    }
    
    func setViewDelegate(locationView: LocationViewDelegate){
        locationDelegate = locationView
    }
    
    func getLocation(idDevice: String) {
        locationInteractor?.getLocation(idDevice: idDevice) { location in
            self.locationDelegate?.setLocation(location: location!)
        }
    }
}
