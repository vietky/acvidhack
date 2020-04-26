//
//  SettingViewController.swift
//  SOSVietnam
//
//  Created by Ecko Huynh on 24/04/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    var hotlines: [Hotline] = [
        Hotline(title: "Đường dây nóng tư vấn COVID-19 cả nước 1", phone: "19009095", address: ""),
        Hotline(title: "Đường dây nóng tư vấn COVID-19 cả nước 2", phone: "19003228", address: ""),
        Hotline(title: "Tổng đài Quốc gia Bảo vệ Trẻ Em", phone: "111", address: ""),
//        Hotline(title: "Y tế", phone: "115", address: ""),
        Hotline(title: "Quản lý, chăm sóc người ăn xin, người già vô gia cư: Trung tâm Hỗ trợ xã hội TPHCM", phone: "08. 35533633", address: "463 Nơ Trang Long, phường 13, quận Bình Thạnh, TPHCM"),
        Hotline(title: "Tư vấn miễn phí cho phụ nữ, trẻ em bị bạo hành gia đình: Ngôi nhà bình yên thuộc Hội LHPN Việt Nam", phone: "1900969680", address: "20, Đường Thụy Khuê, Phường Thụy Khuê, Quận Tây Hồ, Thuỵ Khuê, Tây Hồ, Hà Nội."),
        Hotline(title: "Chăm sóc, hỗ trợ và bảo vệ trẻ em đường phố ở TP HCM: Cơ Sở Bảo Trợ Xã Hội Thảo Đàn", phone: "0928 3846 5410", address: "1 Hai Bà Trưng, Phường 8, Quận 3, Hồ Chí Minh"),
        Hotline(title: "Yêu cầu trợ giúp và tìm kiếm cứu nạn trên phạm vi toàn quốc", phone: "112", address: ""),
        Hotline(title: "Tư vấn bạo lực gia đình: Ngôi nhà Bình yên - Peace House Sheter", phone: "1900 969 680", address: "Phòng Tham vấn- Tầng 4 Nhà B - Trung tâm Phụ nữ và Phát triển Số 20 Thuỵ Khuê, quận Tây Hồ, Hà Nội Điện thoại: ( 84-4 ) 37.280.936 Hoặc 0946.833.380 /0946. 833.384"),
        Hotline(title: "Trung tâm Phụ nữ và Phát triển", phone: "1900 969 680", address: "Số 20 Thuỵ Khuê, quận Tây Hồ, Hà Nội Điện thoại: ( 84-4 ) 37.280.936 Hoặc 0946.833.380 /0946. 833.384"),
        Hotline(title: "Trung tâm Gia đình Châu Á Thái Bình Dương (Centrer for the Pacific Asia Family - CPAF)", phone: "1-800-339-3940", address: ""),
        Hotline(title: "Tư vấn bạo lực gia đình: Tổ chức CSAGA", phone: "(+84-4) 3793 0297", address: "A9 - Cốm Vòng - Dịch Vọng Hậu - Cầu Giấy - Hà Nội. Fax: (+84-4) 3793 0297 Email: csaga@csaga.org.vn"),
    ]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let HotlineTableViewCellNib = UINib(nibName: HotlineTableViewCell.subjectLabel, bundle: nil)
        tableView.register(HotlineTableViewCellNib, forCellReuseIdentifier: HotlineTableViewCell.subjectLabel)
        tableView.delegate = self
        tableView.dataSource = self
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hotlines.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HotlineTableViewCell") as! HotlineTableViewCell
        cell.renderData(hotline: hotlines[indexPath.row])
        return cell
    }
}
