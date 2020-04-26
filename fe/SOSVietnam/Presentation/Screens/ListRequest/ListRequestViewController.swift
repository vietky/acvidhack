//
//  ListRequestViewController.swift
//  SOSVietnam
//
//  Created by Ecko Huynh on 24/04/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class ListRequestViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var requests: [IssueInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        APIClient.getAllIssues { [weak self] (response) in
            if let _ = response.error {
                return
            }
            self?.requests = response.value ?? []
            self?.tableView.reloadData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setUpUI() {
        tableView.delegate = self
        tableView.dataSource = self
        let requestTableViewCellNib = UINib(nibName: RequestTableViewCell.subjectLabel, bundle: nil)
        tableView.register(requestTableViewCellNib, forCellReuseIdentifier: RequestTableViewCell.subjectLabel)
        
        tableView.rowHeight = UITableView.automaticDimension
    }

}
extension ListRequestViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requests.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if requests.count > indexPath.row {
            let item = requests[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: RequestTableViewCell.subjectLabel) as! RequestTableViewCell
            cell.renderData(issueInfo: item)
            cell.callback = { (info, isAccept) in
                if isAccept {
                    
                } else {
                    
                }
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
