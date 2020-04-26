//
//  FormInputTextTableViewCell.swift
//  SOSVietnam
//
//  Created by Ecko Huynh on 24/04/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class FormInputTextTableViewCell: UITableViewCell {
    
    @IBOutlet weak var inputTextfield: UITextField!
    
    var data: FormContent?
    var callback: ((_ value: FormContent)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        inputTextfield.delegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func renderData(content: FormContent) {
        data = content
        inputTextfield.placeholder = content.name
    }
}
extension FormInputTextTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        data?.contentInput = textField.text
        if let data = data {
            callback?(data)
        }
    }
}
