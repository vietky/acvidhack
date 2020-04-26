//
//  SearchViewController.swift
//  SOSVietnam
//
//  Created by Ecko Huynh on 25/04/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import MapKit
class SearchViewController: UIViewController {
    
    let kCellIdentifier = "Cell"
    
    var searchController: UISearchController!
    var tableView: UITableView!
    var tableData: [MKMapItem]?
    
    var tableDataFiltered = [String]()
    
    var callback : ((MKPlacemark) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: view.frame, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: kCellIdentifier)

        let InfoTableViewCellNib = UINib(nibName: InfoTableViewCell.subjectLabel, bundle: nil)
        tableView.register(InfoTableViewCellNib, forCellReuseIdentifier: InfoTableViewCell.subjectLabel)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorEffect = .none
        self.view.addSubview(tableView)
        
        
    }
}
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = tableData?[indexPath.row].placemark
        let cell = tableView.dequeueReusableCell(withIdentifier: InfoTableViewCell.subjectLabel, for: indexPath) as! InfoTableViewCell
        let address = "\(data?.thoroughfare ?? ""), \(data?.locality ?? ""), \(data?.subLocality ?? ""), \(data?.administrativeArea ?? ""), \(data?.postalCode ?? ""), \(data?.country ?? "")"
        if let name = data?.name {
            cell.renderData(title: name, subtitle: address)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let placemark = tableData?[indexPath.row].placemark {
            callback?(placemark)
        }
        self.dismiss(animated: true, completion: nil)
    }
}
