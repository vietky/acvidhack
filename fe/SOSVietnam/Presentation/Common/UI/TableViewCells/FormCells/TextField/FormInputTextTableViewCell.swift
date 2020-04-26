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
    var isReview = false
    
    var callback: ((_ value: FormContent)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        inputTextfield.delegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func renderData(content: FormContent, isReview: Bool = false) {
        self.isReview = isReview
        data = content
        inputTextfield.placeholder = content.name
        if let contentInput = content.contentInput as? String, contentInput.isNotEmpty {
            inputTextfield.text = contentInput
            inputTextfield.textColor = UIColor.black
        }
    }
}
extension FormInputTextTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        data?.contentInput = textField.text
        if let data = data {
            callback?(data)
        }
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if isReview { return false }
        return true
    }
}
