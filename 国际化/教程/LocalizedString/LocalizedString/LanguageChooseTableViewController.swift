//
//  LanguageChooseTableViewController.swift
//  LocalizedString
//
//  Created by tlc on 2018/5/2.
//  Copyright © 2018年 tlc. All rights reserved.
//

import UIKit

class LanguageChooseTableViewController: UITableViewController {

    var languages = ["简体中文", "繁體中文", "English"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: nil, style: .done, target: nil, action: nil)    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - Table view data source
extension LanguageChooseTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = languages[indexPath.row]
        if LanguageManager.share.getLanguageType(languageChooseVC: indexPath.row) == LanguageManager.share.languageType {
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let chooseType = LanguageManager.share.getLanguageType(languageChooseVC: indexPath.row)
        if chooseType != LanguageManager.share.languageType {
            LanguageManager.share.changeLocalLanguage(type: chooseType)
            tableView.reloadData()
        }
    }
}
