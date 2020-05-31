//
//  HomeViewController.swift
//  WhereAmI
//
//  Created by Aldo Corona on 30/04/20.
//  Copyright © 2020 IMOX. All rights reserved.
//

import Foundation
import UIKit
import SQLite3

class HomeViewController: ViewController, UITableViewDataSource, UITableViewDelegate, HomeViewControllerDelegate{
    var tracked: [TrackedModel] = []
    @IBOutlet weak var confHomeBtn: UIButton!
    @IBOutlet weak var tabView: UITableView!
    var token: String = ""
    var homePresenter: HomePresenter = HomePresenter()
    
    override func viewDidLoad() {
        self.navigationItem.setHidesBackButton(true, animated: false)
        confHomeBtn.backgroundColor = UIColor(red: brgb, green: brgb, blue: brgb, alpha: 1)
        homePresenter.setViewDelegate(homeView: self)
        homePresenter.getTracked(token: self.token)
    }
    
    @IBAction func confhomeBtnClicker(_ sender: Any) {
        let confVC = self.storyboard?.instantiateViewController(withIdentifier: "confVC") as! ConfigurationViewController
        confVC.token = self.token
        self.navigationController?.pushViewController(confVC, animated: true)
    }
    
    func setTracked(tracked: [TrackedModel]) {
        self.tracked = tracked
        DispatchQueue.main.async {
            self.tabView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracked.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell=UITableViewCell(style: .subtitle, reuseIdentifier: "mycell")
        let track = tracked[indexPath.row]
        cell.textLabel?.text = track.name
        cell.detailTextLabel?.text = track.idDevice
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let locationVC = self.storyboard?.instantiateViewController(withIdentifier: "locationVC") as! LocationViewController
        let track = tracked[indexPath.row]
        locationVC.name = track.name
        locationVC.idDevice = track.idDevice
        self.navigationController?.pushViewController(locationVC, animated: true)
    }
}

protocol HomeViewControllerDelegate {
    func setTracked(tracked: [TrackedModel])
}
