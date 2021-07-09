//
//  ViewController.swift
//  NewsFeed
//
//  Created by Karan Bhatt on 09/07/21.
//  Copyright © 2021 Anand Patel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
   
    fileprivate let viewModel = ListViewModel()

    let manager = ListManager()

    var param = Query(country: UserDefaults.standard.object(forKey: UserDefaultsLanguageCode ) as? String ?? "us", page: "", id: ApiKey, count: "30")

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.dataSource = viewModel
        tableView?.estimatedRowHeight = 100
        tableView?.rowHeight = UITableView.automaticDimension
        tableView?.register(ListCell.nib, forCellReuseIdentifier: ListCell.identifier)
        setUpData()
    }
    
    private func setUpData(){
        manager.request(query: param){  (results) in
            self.viewModel.data(results: results?.articles ?? [])
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
}
