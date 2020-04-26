//
//  FormTextViewTableViewCell.swift
//  SOSVietnam
//
//  Created by Ecko Huynh on 24/04/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class FormTextViewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var contentTextView: UITextView!
    
    var data: FormContent?
    var isFirst = true
    
    var callback: ((_ value: FormContent)->())?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentTextView.layer.borderWidth = 1.0
        self.contentTextView.layer.borderColor = UIColor(hexFromString: "E5E5E6").cgColor
        contentTextView.delegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func renderData(content: FormContent) {
        self.data = content
        if let contentInput = content.contentInput as? String, contentInput.isNotEmpty {
            contentTextView.text = contentInput
            contentTextView.textColor = UIColor.black
        } else {
            contentTextView.text = content.name
            contentTextView.textColor = UIColor.lightGray
        }
    }
}
extension FormTextViewTableViewCell: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        contentTextView.textColor = UIColor.black
        return true
    }
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if isFirst {
            contentTextView.text = ""
            isFirst = false
        }
        return true
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            contentTextView.text = data?.name
            isFirst = true
            return
        }
        contentTextView.text = textView.text
        data?.contentInput = contentTextView.text
        if let data = data {
            callback?(data)
        }
    }
}
