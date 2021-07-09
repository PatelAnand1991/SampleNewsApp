//
//  ListCell.swift
//  NewsFeed
//
//  Created by Karan Bhatt on 09/07/21.
//  Copyright © 2021 Anand Patel. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {

    @IBOutlet weak var headLines: UILabel?
    @IBOutlet weak var readMore: UILabel?
    
    var item: ListViewModelItem? {
        didSet {
            guard let item = item as? ListItem else {
                return
            }
            headLines?.text = item.headLine
            readMore?.text = item.overView
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
        headLines?.text = nil
        readMore?.text = nil
    }
}
