//
//  ViewController.swift
//  NewsFeed
//
//  Created by Karan Bhatt on 09/07/21.
//  Copyright © 2021 Anand Patel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: ChooseLanguageVC.self)) as! ChooseLanguageVC
            self.navigationController?.pushViewController(vc, animated: true)
        // Do any additional setup after loading the view.
    }


}

