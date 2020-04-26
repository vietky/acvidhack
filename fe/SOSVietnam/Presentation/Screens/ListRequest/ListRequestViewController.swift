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
            cell.callback = { [weak self] (info, isAccept) in
                if isAccept {
                    self?.showDetail(index: indexPath.row)
                } else {
                     self?.showMessage(index: indexPath.row)
                }
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func showDetail(index: Int) {
        let formRequestViewController = FormRequestViewController()
        formRequestViewController.issueInfo = requests[index]
        formRequestViewController.isReview = true
        navigationController?.present(formRequestViewController, animated: true, completion: nil)
    }
    
    func showMessage(index: Int) {
        let messageViewController = MessageViewController()
        messageViewController.text = "Cám ơn lòng tốt của bạn. Yêu cầu giúp đỡ của bạn đã được ghi nhận. \n Chúng tôi sẽ liên hệ và xác thực trong thời gian sớm nhất."
        navigationController?.present(messageViewController, animated: true, completion: nil)
    }
}
