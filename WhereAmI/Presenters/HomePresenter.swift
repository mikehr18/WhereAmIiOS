//
//  HomePresenter.swift
//  WhereAmI
//
//  Created by Aldo Corona on 29/05/20.
//  Copyright © 2020 IMOX. All rights reserved.
//

import Foundation

class HomePresenter {
    let homeInteractor: HomeInteractor?
    var homeViewDelegate: HomeViewControllerDelegate?
    
    init() {
        homeInteractor = HomeInteractor()
    }
    
    func setViewDelegate(homeView: HomeViewControllerDelegate) {
        self.homeViewDelegate = homeView
    }
    
    func getTracked(token: String){
        homeInteractor?.getTracked(token: token) { tracked in
            self.homeViewDelegate?.setTracked(tracked: tracked!)
        }
    }
}
