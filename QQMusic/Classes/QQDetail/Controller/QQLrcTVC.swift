//
//  QQLrcTVC.swift
//  QQMusic
//
//  Created by chen on 16/5/17.
//  Copyright © 2016年 chen. All rights reserved.
//

import UIKit

class QQLrcTVC: UITableViewController {

    var dataSource: [QQLrcModel] = [QQLrcModel]() {
        didSet {
            tableView.reloadData()
        }
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //设置tableView
        tableView.separatorStyle = .None
        
        tableView.allowsSelection = false
    }

    

    

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataSource.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       let cell = QQLrcCell.cellWithTableView(tableView)

        let lrcM = dataSource[indexPath.row]
        
        cell.lrcStr = lrcM.lrcStr
        
        return cell
    }
    


}
