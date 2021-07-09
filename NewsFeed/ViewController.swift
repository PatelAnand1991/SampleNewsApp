//
//  ViewController.swift
//  NewsFeed
//
//  Created by Karan Bhatt on 09/07/21.
//  Copyright © 2021 Anand Patel. All rights reserved.
//

import UIKit

class ViewController: UIViewController, LanguageVCDelegate {
    
    var refreshControl = UIRefreshControl()
    @IBOutlet weak var tableView: UITableView!
   @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!

    fileprivate let viewModel = ListViewModel()

    let manager = ListManager()

    var param = Query(country: UserDefaults.standard.object(forKey: UserDefaultsLanguageCode ) as? String ?? "us", page: "0", id: ApiKey, count: "30")

    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.RefreshTapped(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        tableView?.dataSource = viewModel
        tableView?.estimatedRowHeight = 100
        tableView?.rowHeight = UITableView.automaticDimension
        tableView?.register(ListCell.nib, forCellReuseIdentifier: ListCell.identifier)
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image:  UIImage.init(named: "Setting.png"), style: .plain, target: self, action: #selector(self.SettingTapped))
        self.navigationItem.title = "NEWS"
        loadingActivityIndicator.startAnimating()
        setUpData()
    }
    
    private func setUpData(){
        manager.request(query: param){  (results) in
            self.viewModel.items.removeAll()
            self.viewModel.data(results: results?.articles ?? [])
            DispatchQueue.main.async {
                self.loadingActivityIndicator.stopAnimating()
                self.refreshControl.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @objc func RefreshTapped(_ sender:UIBarButtonItem!)
    {
        setUpData()
       
    }
    
    @objc func SettingTapped(_ sender:UIBarButtonItem!)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: ChooseLanguageVC.self)) as! ChooseLanguageVC
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func didSelectData(_ ContryCode: String) {
        param = Query(country: UserDefaults.standard.object(forKey: UserDefaultsLanguageCode ) as? String ?? "us", page: "", id: ApiKey, count: "30")
        setUpData()
    }
    
}

//MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as! DetailViewController
        let details = viewModel.items[indexPath.row]
        vc.ArticalDetails = (details as! ListItem)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
