//
//  ListNewsViewController.swift
//  SOSVietnam
//
//  Created by Ecko Huynh on 24/04/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import Kingfisher
class ListNewsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var news: [NewsFeed] = [NewsFeed(id: 1, title: "Nở rộ mô hình “ATM gạo” hỗ trợ người nghèo tại TP Hồ Chí Minh", description: "Vì mục đích hỗ trợ người lao động nghèo, khó khăn do dịch Covid-19, chỉ một thời gian ngắn sau khi “ATM gạo” đầu tiên ra đời ở quận Tân Phú (TP Hồ Chí Minh), mô hình đã được nhanh chóng lan tỏa khắp TP", image: "http://cdn.kinhtedothi.vn/617/2020/4/18/anh%207.jpeg", url: "http://kinhtedothi.vn/no-ro-mo-hinh-atm-gao-ho-tro-nguoi-ngheo-tai-tp-ho-chi-minh-381650.html")
        , NewsFeed(id: 2, title: "Chính phủ nâng gói ASXH lên 62 nghìn tỷ đồng, hỗ trợ khoảng 20 triệu người khó khăn do Covid-19", description: "Theo tính toán của Chính phủ, gói hỗ trợ người gặp khó khăn do đại dịch Covid-19 sẽ có trị giá 62 nghìn tỷ đồng (tăng 420 tỷ so với dự kiến ban đầu), hỗ trợ dành cho khoảng 20 triệu người của 6 nhóm đối tượng", image: "http://www.molisa.gov.vn/Upload/Images/imgmdqd4902-1586648873184464609574.jpg", url: "")
        , NewsFeed(id: 3, title: "Những cây ATM gạo", description: "Chúng tôi cũng nhận thấy nhiều nhà hảo tâm muốn ủng hộ người nghèo nhưng chưa biết làm sao, bởi làm thiện nguyện không phải dễ dàng, nên với ATM gạo", image: "https://image.thanhnien.vn/660/uploaded/minhnguyet/2020_04_13/atmtudong_enfn.jpg", url: "https://thanhnien.vn/gioi-tre/nhung-cay-atm-gao-1210278.html?fbclid=IwAR1wqN1hH4HGYFnmEYcesSy3Jl08IRUt6hskeLA94socKUzEpEd5usL46Lk")
        , NewsFeed(id: 4, title: "'ATM gạo' xuất hiện ở Cà Mau, người nghèo phấn khởi giữa dịch Covid-19", description: "Không cần chạm tay, ATM gạo tự động cho gạo chạy vào tay người nghèo ở TP.Cà Mau (Cà Mau) giúp người nghèo vượt qua khó khăn trong thời gian cách ly phòng dịch Covid-19", image: "https://image.thanhnien.vn/660/uploaded/diepnh/2020_04_13/92827078_247538312959078_5213234559470010368_n_mqet.jpg", url: "https://thanhnien.vn/doi-song/atm-gao-xuat-hien-o-ca-mau-nguoi-ngheo-phan-khoi-giua-dich-covid-19-1210340.html")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        
        let topRightTextItem = UIBarButtonItem(title: "Thống kê", style: .plain, target: self, action: #selector(back(sender:)))
        topRightTextItem.tintColor = UIColor(hexFromString: "F40B32")
        navigationController?.navigationBar.topItem?.rightBarButtonItem = topRightTextItem
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    @objc
    func back(sender: UIBarButtonItem) {
        
    let analysisViewController = AnalysisViewController()
        navigationController?.present(analysisViewController, animated: true, completion: nil)
    }
    
    func setUpUI() {
        tableView.delegate = self
        tableView.dataSource = self
        let newsTableViewCellNib = UINib(nibName: NewsTableViewCell.subjectLabel, bundle: nil)
        tableView.register(newsTableViewCellNib, forCellReuseIdentifier: NewsTableViewCell.subjectLabel)
        
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func showShareSheet(shareableLink: String, title: String, imageName: String) {
        var items: [Any] = [title]
        
        if let link = URL(string: shareableLink) {
            items.append(link)
        }
        
        if let shareableImage = UIImage(named: imageName) {
            items.append(shareableImage)
        }
        
        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        if let popoverController = activityViewController.popoverPresentationController
            , UIDevice.isPad {
            popoverController.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2, width: 1, height: 1)
            popoverController.sourceView = navigationController!.view
            popoverController.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
        }
        navigationController?.present(activityViewController, animated: true, completion: nil)
    }
}
extension ListNewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if news.count > indexPath.row {
            let item = news[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell") as! NewsTableViewCell
            cell.renderData(feed: item)
            cell.callbackCell = { [weak self] value in
                self?.showWebView(feed: value)
            }
            cell.callbackShare = { [weak self] value in
                self?.showShareSheet(shareableLink: value.description, title: value.title, imageName: value.image)
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func showWebView(feed: NewsFeed) {
        let webViewController = WebViewController()
        webViewController.url = URL(string: feed.url)
        navigationController?.present(webViewController, animated: true, completion: nil)
    }
}
