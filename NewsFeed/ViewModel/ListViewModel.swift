//
//  ListViewModel.swift
//  NewsFeed
//
//  Created by Karan Bhatt on 09/07/21.
//  Copyright © 2021 Anand Patel. All rights reserved.
//

import Foundation
import UIKit

enum ListViewModelItemType {
    case list
    case details
    case noResult
}


protocol ListViewModelItem {
    var type: ListViewModelItemType { get }
    var sectionTitle: String { get }
    var rowCount: Int { get }
}


class ListViewModel: NSObject {
    var items = [ListViewModelItem]()
   
    var type:ListViewModelItemType = .list

    override init() {
        
        super.init()
    }

    func data(results: [Articles?]){
        if results.count > 0 {
            for result in results {
                
                let details = ListItem(headLine: result?.title ?? "", overView: result?.description ?? "", date: result?.publishedAt ?? "", author: result?.author ?? "", url: result?.url ?? "", urlToImage: result?.urlToImage ?? "", publishedAt: result?.publishedAt ?? "")
                items.append(details)

            }
        }else{
            //Handle no results
            let noResult = NoResultsItem(name:"No Results found, please try again.")
            items.append(noResult)
            print("❌")
        }
    }
}


//MARK: - UITableViewDataSource
extension ListViewModel: UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return  1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        switch item.type {
        case .list:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier, for: indexPath) as? ListCell {
                cell.item = item
                return cell
            }
        case .noResult:
            return UITableViewCell()
        case .details:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
}


//MARK: - VM
struct DetailsItem: ListViewModelItem {
    var type: ListViewModelItemType {
        return .details
    }
    
    var sectionTitle: String {
        return self.date
    }
    
    var rowCount: Int {
        return 1
    }
    
    var name: String
    var pictureUrl: String
    var overView: String
    var date: String

    init(name: String, pictureUrl: String, overView: String, date: String) {
        self.name = name
        self.pictureUrl = pictureUrl
        self.overView = overView
        self.date = date
    }
}


struct ListItem: ListViewModelItem {
    var type: ListViewModelItemType {
        return .list
    }
    
    var sectionTitle: String {
        return self.date
    }
    
    var rowCount: Int {
        return 1
    }
    
    var headLine: String
    var overView: String
    var date: String
    
    var author: String
    var url: String
    var urlToImage: String
    var publishedAt: String

    
    init(headLine: String, overView: String, date: String , author : String , url : String, urlToImage : String, publishedAt : String) {
        self.headLine = headLine
        self.overView = overView
        self.date = date
        
         self.author = author
         self.url = url
         self.urlToImage = urlToImage
         self.publishedAt = publishedAt
    }
}




struct NoResultsItem: ListViewModelItem {
    var type: ListViewModelItemType {
        return .noResult
    }
    
    var sectionTitle: String {
        return self.name
    }
    
    var rowCount: Int {
        return 0
    }
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
