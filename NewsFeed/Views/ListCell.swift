//
//  ListCell.swift
//  NewsFeed
//
//  Created by Karan Bhatt on 09/07/21.
//  Copyright © 2021 Anand Patel. All rights reserved.
//

import UIKit
import SDWebImage

class ListCell: UITableViewCell {

    
    
    @IBOutlet weak var lblTitle: UILabel! {
        didSet {
            lblTitle.textColor = UIColor.black
        }
    }
    @IBOutlet weak var lblAuthor: UILabel! {
        didSet {
            lblAuthor.textColor = UIColor.lightGray
        }
    }

    @IBOutlet weak var lblPublishedAt: UILabel! {
        didSet {
            lblPublishedAt.textColor = UIColor.darkGray

        }
    }
    @IBOutlet weak var articleImageView: UIImageView!

    
    var item: ListViewModelItem? {
        didSet {
            guard let article = item as? ListItem else {
                return
            }
            
            lblTitle?.text = article.headLine
            lblAuthor?.text = article.author
            lblPublishedAt?.text = article.publishedAt.UTCToShortLocal()
                self.articleImageView.sd_setImage(with: URL(string: article.urlToImage), placeholderImage: UIImage(named: "placeholder"))
        }
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        lblTitle?.text = nil
        lblAuthor?.text = nil
        lblPublishedAt?.text = nil
    }
}
