//
//  DetailViewController.swift
//  NewsFeed
//
//  Created by Karan Bhatt on 10/07/21.
//  Copyright © 2021 Anand Patel. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var ArticalDetails: ListItem?
    
    
    // MARK: - IBOutlets and Variables
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var publishedDataLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    
    
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.loadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Local Class Methods
    
    func loadData() {
        // Setting Data
        
        guard let article = ArticalDetails else {
            return
        }
        print(article)
        self.title = article.author == "" ? "Detail" : article.author
        self.titleLabel.text = article.headLine
        self.detailLabel.text = article.overView
        self.publishedDataLabel.text = article.publishedAt.UTCToLongLocal()
        self.articleImageView.sd_setImage(with: URL(string: article.urlToImage), placeholderImage: UIImage(named: "placeholder"), options: .highPriority, completed: { [weak self] (_, _, _, _)  in
        })
    }
    
    // MARK: - IBActions
    @IBAction func gotoURLTap(_ sender: UIButton) {
        guard let article = ArticalDetails else {
            return
        }
        
        guard let url = URL(string: (article.url)) else { return }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
