//
//  FormRequestViewController.swift
//  SOSVietnam
//
//  Created by Ecko Huynh on 24/04/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import Alamofire
class FormRequestViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    //    var issueName = FormContent(id: 2, name: "Nhập yêu cầu (*)", type: .textField, isRequired: true)
    
    var formData = FormData(sections: [
        FormSection(id: 0, title: "", contentItems:
            [
                FormContent(id: 1, name: "Mời chọn loại yêu cầu (*)", type: .textField, isRequired: true),
                FormContent(id: 2, name: "Bạn có thể nói rõ thêm.", type: .textBox, isRequired: false)]),
        FormSection(id: 3, title: "Thông tin để chúng tôi có thể hỗ trợ", contentItems:
            [
                FormContent(id: 4, name: "Họ tên (*)", type: .textField, isRequired: true),
                FormContent(id: 5, name: "Số điện thoại", type: .textField, isRequired: false),
                FormContent(id: 6, name: "Địa chỉ", type: .textField, isRequired: false),
                //                FormContent(id: 8, name: "Email", type: .textField, isRequired: false),
                //                FormContent(id: 9, name: "Chứng minh thư/ Hộ chiếu", type: .textField, isRequired: false),
                FormContent(id: 10, name: "Image", type: .uploadImage, isRequired: false),
                FormContent(id: 11, name: "Tôi chính là người đang cần giúp đỡ", type: .checkbox, isRequired: false, isSelected: true),
                FormContent(id: 12, name: "Không có nơi nương tựa, hoặc nhà cửa không an toàn", type: .checkbox, isRequired: false),
                FormContent(id: 13, name: "Bệnh thể chất hoặc có những chứng bệnh tiềm ẩn (bệnh tim, cao huyết áp, tiểu đường, bệnh hô hấp mãn tính, ung thư)", type: .checkbox, isRequired: false),
                FormContent(id: 14, name: "", type: .urgency, isRequired: false),
                FormContent(id: 15, name: "", type: .sendForm, isRequired: false)
        ]),
        ]
    )
    
    var issueInfo: IssueInfo? = nil
    var imagePickerController : UIImagePickerController?
    
    var isReview = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        //        if !(self.navigationController?.isNavigationBarHidden ?? false) {
        //            self.navigationController?.isNavigationBarHidden = true
        //        }
        if let issueInfo = issueInfo, isReview {
            formData = FormData(sections: [
            FormSection(id: 0, title: "", contentItems:
                [
                    FormContent(id: 1, name: "Mời chọn loại yêu cầu (*)", type: .textField, isRequired: true, contentInput: issueInfo.issueType),
                    FormContent(id: 2, name: "Bạn có thể nói rõ thêm.", type: .textBox, isRequired: false, contentInput: issueInfo.issueDescription)]),
            FormSection(id: 3, title: "Thông tin để chúng tôi có thể hỗ trợ", contentItems:
                [
                    FormContent(id: 4, name: "Họ tên (*)", type: .textField, isRequired: true, contentInput: issueInfo.fullName),
                    FormContent(id: 5, name: "Số điện thoại", type: .textField, isRequired: false , contentInput: issueInfo.phone),
                    FormContent(id: 6, name: "Địa chỉ", type: .textField, isRequired: false, contentInput: issueInfo.address),
                    FormContent(id: 12, name: "Không có nơi nương tựa, hoặc nhà cửa không an toàn", type: .checkbox, isRequired: issueInfo.isHomeless ?? false, isSelected: issueInfo.isHomeless ?? false),
                    FormContent(id: 13, name: "Bệnh thể chất hoặc có những chứng bệnh tiềm ẩn (bệnh tim, cao huyết áp, tiểu đường, bệnh hô hấp mãn tính, ung thư)", type: .checkbox, isRequired: false, isSelected: issueInfo.isWellBeing ?? issueInfo.isDisability ?? false),
                    FormContent(id: 14, name: "", type: .urgency, isRequired: false)
            ]),
            ])
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        //        self.navigationController?.isNavigationBarHidden = false
    }
    
    func setUpUI() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let formInputTextTableViewCellNib = UINib(nibName: FormInputTextTableViewCell.subjectLabel, bundle: nil)
        tableView.register(formInputTextTableViewCellNib, forCellReuseIdentifier: FormInputTextTableViewCell.subjectLabel)
        
        let formCheckboxTableViewCellNib = UINib(nibName: FormCheckboxTableViewCell.subjectLabel, bundle: nil)
        tableView.register(formCheckboxTableViewCellNib, forCellReuseIdentifier: FormCheckboxTableViewCell.subjectLabel)
        
        let formTextViewTableViewCellNib = UINib(nibName: FormTextViewTableViewCell.subjectLabel, bundle: nil)
        tableView.register(formTextViewTableViewCellNib, forCellReuseIdentifier: FormTextViewTableViewCell.subjectLabel)
        
        let UrgencyTableViewCellNib = UINib(nibName: UrgencyTableViewCell.subjectLabel, bundle: nil)
        tableView.register(UrgencyTableViewCellNib, forCellReuseIdentifier: UrgencyTableViewCell.subjectLabel)
        
        let SendTableViewCellNib = UINib(nibName: SendTableViewCell.subjectLabel, bundle: nil)
        tableView.register(SendTableViewCellNib, forCellReuseIdentifier: SendTableViewCell.subjectLabel)
        
        let PickerTableViewCellNib = UINib(nibName: PickerTableViewCell.subjectLabel, bundle: nil)
        tableView.register(PickerTableViewCellNib, forCellReuseIdentifier: PickerTableViewCell.subjectLabel)
        
        let ImageTableViewCellNib = UINib(nibName: ImageTableViewCell.subjectLabel, bundle: nil)
        tableView.register(ImageTableViewCellNib, forCellReuseIdentifier: ImageTableViewCell.subjectLabel)
        
        
        tableView.rowHeight = UITableView.automaticDimension
        
        //        imagePickerController = UIImagePickerController()
        //        imagePickerController?.delegate = self
    }
    
    func showAlertController(alertController: UIAlertController) {
        
        navigationController?.present(alertController, animated: true, completion: nil)
    }
    
    func sendCreateIssue() {
        let missingFields = validateForm()
        if missingFields.isNotEmpty {
            let alert = UIAlertController.alertController(forTitle: "Lỗi", message: "Xin vui lòng nhập đầy đủ các thông tin như:  \(missingFields)")
            showAlertController(alertController: alert)
            return
        }
        
        var info = IssueInfo(id: -1,
                             issueName: formData.sections[1].contentItems.first(where: { $0.id == 4})?.contentInput as? String,
                             issueType: formData.sections[0].contentItems.first(where: { $0.id == 1})?.contentInput as? String,
                             issueDescription: formData.sections[0].contentItems.first(where: { $0.id == 2})?.contentInput as? String,
                             fullName: formData.sections[1].contentItems.first(where: { $0.id == 4})?.contentInput as? String,
                             address: formData.sections[1].contentItems.first(where: { $0.id == 6})?.contentInput as? String,
                             birthday: formData.sections[1].contentItems.first(where: { $0.id == 4})?.contentInput as? String,
                             phone: formData.sections[1].contentItems.first(where: { $0.id == 5})?.contentInput as? String,
                             email: nil, identifyId: nil, sex: nil, createDate: nil, closeDate: nil,
                             isWellBeing: formData.sections[1].contentItems.first(where: { $0.id == 13})?.isSelected,
                             isDisability: formData.sections[1].contentItems.first(where: { $0.id == 13})?.isSelected,
                             isHomeless: formData.sections[1].contentItems.first(where: { $0.id == 12})?.isSelected,
                             urgencyEvaluate: nil)
        APIClient.createIssue(issue: info, completion: { [weak self] (response) in
            if let _ = response.error {
                return
            }
            let messageViewController = MessageViewController()
            self?.navigationController?.present(messageViewController, animated: true, completion: nil)
            print("Ecko \(response)")
        })
    }
    
    func validateForm() -> String {
        var missingField = ""
        for section in formData.sections {
            for content in section.contentItems where content.isRequired {
                if content.contentInput == nil {
                    missingField = missingField + ", \(content.name)"
                }
            }
        }
        return missingField
    }
}
extension FormRequestViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return formData.sections[section].contentItems.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return formData.sections.count
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.textColor = UIColor(hexFromString: "F40B32")
            header.tintColor = .white
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return formData.sections[section].title
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if formData.sections.count > indexPath.section && formData.sections[indexPath.section].contentItems.count > indexPath.row {
            let formContent = formData.sections[indexPath.section].contentItems[indexPath.row]
            switch formContent.type {
            case .textField where formContent.id == 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: PickerTableViewCell.subjectLabel) as! PickerTableViewCell
                cell.renderData(content: formContent, isReview: self.isReview)
                cell.callbackReload = { [weak self] in
                    self?.tableView.reloadData()
                }
                cell.callback = { [weak self] value in
                    self?.updateData(value: value, index: indexPath)
                }
                return cell
            case .textBox:
                let cell = tableView.dequeueReusableCell(withIdentifier: FormTextViewTableViewCell.subjectLabel) as! FormTextViewTableViewCell
                cell.renderData(content: formContent, isReview: self.isReview)
                cell.callback = { [weak self] value in
                    self?.updateData(value: value, index: indexPath)
                }
                return cell
            case .checkbox:
                let cell = tableView.dequeueReusableCell(withIdentifier: FormCheckboxTableViewCell.subjectLabel) as! FormCheckboxTableViewCell
                cell.renderData(content: formContent, isReview: self.isReview)
                cell.callback = { [weak self] value in
                    self?.updateData(value: value, index: indexPath)
                }
                return cell
            case .textField:
                let cell = tableView.dequeueReusableCell(withIdentifier: FormInputTextTableViewCell.subjectLabel) as! FormInputTextTableViewCell
                cell.renderData(content: formContent, isReview: self.isReview)
                cell.callback = { [weak self] value in
                    self?.updateData(value: value, index: indexPath)
                }
                return cell
            case .urgency:
                let cell = tableView.dequeueReusableCell(withIdentifier: UrgencyTableViewCell.subjectLabel) as! UrgencyTableViewCell
                cell.renderData(content: formContent, isReview: self.isReview)
                cell.callback = { [weak self] value in
                    self?.updateData(value: value, index: indexPath)
                }
                return cell
            case .sendForm:
                let cell = tableView.dequeueReusableCell(withIdentifier: SendTableViewCell.subjectLabel) as! SendTableViewCell
                cell.callback = { [weak self] value in
                    self?.sendCreateIssue()
                }
                return cell
            case .uploadImage:
                let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.subjectLabel) as! ImageTableViewCell
                cell.callback = { [weak self] value in
                    self?.showImage()
                }
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func updateData(value: FormContent, index: IndexPath) {
        formData.sections[index.section].contentItems[index.row].contentInput = value.contentInput
        formData.sections[index.section].contentItems[index.row].isSelected = value.isSelected
        tableView.reloadData()
    }
    
    func showImage() {
        imagePickerController = UIImagePickerController()
        imagePickerController?.delegate = self
        imagePickerController?.sourceType = .photoLibrary
        navigationController?.present(imagePickerController!, animated: true, completion:nil)
    }
    
}
extension FormRequestViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        navigationController?.dismiss(animated: true, completion: nil)
        if let image: UIImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            saveImage(imageName: "", image: image)
        }
    }
    func saveImage(imageName: String, image: UIImage ){
        // Handle image https://appsandbiscuits.com/take-save-and-retrieve-a-photo-ios-13-4312f96793ff
        //create an instance of the FileManager
        let fileManager = FileManager.default
        //get the image path
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        //get the image we took with camera
        let image = image
        //get the PNG data for this image
        let data = image.pngData()
        //store it in the document directory
        fileManager.createFile(atPath: imagePath as String, contents: data, attributes: nil)
    }
}
