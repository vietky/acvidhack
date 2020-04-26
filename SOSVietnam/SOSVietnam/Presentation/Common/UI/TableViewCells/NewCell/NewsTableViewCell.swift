//
//  NewsTableViewCell.swift
//  SOSVietnam
//
//  Created by Ecko Huynh on 24/04/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import Kingfisher
class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var pannelImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    
    var feed: NewsFeed?
    
    // Callback variable
    var callbackShare: ((_ value: NewsFeed)->())?
    var callbackCell: ((_ value: NewsFeed)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func renderData(feed: NewsFeed) {
        self.feed = feed
        pannelImage.kf.setImage(with: URL(string: feed.image))
        self.pannelImage.layer.masksToBounds = true
        self.pannelImage.layer.cornerRadius = 8
        titleLabel.text = feed.title
        subtitleLabel.text = feed.description
    }
    
    @IBAction func shareClick(_ sender: Any) {
        if let feed = self.feed {
            callbackShare?(feed)
        }
    }
    
    @IBAction func cellClick(_ sender: Any) {
        if let feed = self.feed {
            callbackCell?(feed)
        }
        
    }
    
}
