//
//  PickerTableViewCell.swift
//  SOSVietnam
//
//  Created by Ecko Huynh on 25/04/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class PickerTableViewCell: UITableViewCell {

    @IBOutlet weak var pickerTextField: UITextField!
    @IBOutlet weak var pickerDataView: UIPickerView!
    
    @IBOutlet weak var bottomTextfieldConstraint: NSLayoutConstraint!
    var callback: ((_ value: FormContent)->())?
    var callbackReload: ((_ value: Void)->())?
     var data: FormContent?
    
    var list = [IssueType(key: "Gorceries", name: "Hỗ trợ về lương thực"), IssueType(key: "Medicine", name: "Hỗ trợ về thuốc men"), IssueType(key: "Clothes", name: "Hỗ trợ về quần áo"), IssueType(key: "Social issues", name: "Hỗ trợ về tệ nạn xã hội"), IssueType(key: "Others", name: "Các vấn đề khác")]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pickerTextField.delegate = self
        pickerDataView.delegate = self
        pickerDataView.dataSource = self
        pickerDataView.isHidden = true
        
        bottomTextfieldConstraint.constant = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func renderData(content: FormContent) {
        self.data = content
        if  let contentInput = self.data?.contentInput as? String {
            pickerTextField.text = contentInput
        } else {
            pickerTextField.text = self.data?.name
        }
        
    }
    
}
extension PickerTableViewCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row].name
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerTextField.text = list[row].name
        pickerDataView.isHidden = true
        bottomTextfieldConstraint.constant = 0
        data?.contentInput = list[row].name
        if let data = data {
            callback?(data)
        }
    }
}
extension PickerTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        pickerDataView.isHidden = false
        bottomTextfieldConstraint.constant = 150
        callbackReload?(())
        return false
    }
}
