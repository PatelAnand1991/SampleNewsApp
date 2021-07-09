//
//  ChooseLanguageVC.swift
//  NewsFeed
//
//  Created by Karan Bhatt on 09/07/21.
//  Copyright © 2021 Anand Patel. All rights reserved.
//

import UIKit

class ChooseLanguageVC: UIViewController {

    
    var languageArray = [NSDictionary]()
    @IBOutlet var tblview: UITableView!
    @IBOutlet weak var ActionButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblview.tableFooterView = UIView()
        self.navigationItem.title = kChooseLanguage
        self.getlanguageDetails()
    }
    
     func getlanguageDetails () {
        languageArray.append(["name":"United States", "code":"us"])
        languageArray.append(["name":"Canada", "code":"ca"])
       tblview.reloadData()
    }

}

//MARK: - UITableViewDelegate & UITableViewDataSource

extension ChooseLanguageVC: UITableViewDelegate,UITableViewDataSource
{
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return languageArray.count
        }
        
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChooseLanguageCell", for: indexPath) as! ChooseLanguageCell
            
            // set cell selection style
            cell.selectionStyle = .default
            cell.lbl_name.text = languageArray[indexPath.row]["name"] as? String
            if( String(describing: languageArray[indexPath.row]["code"]      ?? "") == UserDefaults.standard.object(forKey: UserDefaultsLanguageCode ) as? String) {
                cell.accessoryType = .checkmark
            }
            else{
                cell.accessoryType = .none
            }
            return cell
        }
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            let defaults = UserDefaults.standard
             defaults.setValue(UserDefaults.standard.object(forKey: UserDefaultsLanguageCode ) as? String, forKey: UserDefaultsLanguageCode)
            defaults.synchronize()
        }
}

