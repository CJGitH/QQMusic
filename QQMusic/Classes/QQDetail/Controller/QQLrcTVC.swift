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
    
    
    var progress: Double = 0.0 {
        didSet {
            
            // 1. 获取到当前正在播放的cell
            let index = NSIndexPath(forRow: scrollRow, inSection: 0)
            let cell = tableView.cellForRowAtIndexPath(index) as? QQLrcCell
            
            // 2. 给cell, progress , 赋值
            cell?.progress = progress
            
        }
    }
    
    
    var scrollRow: Int = 0 {
        didSet {
            
            // 防止重复滚动
            
            if scrollRow != oldValue {
                
                
                // 先刷新, 再做动画, 不然, 有问题
                tableView.reloadRowsAtIndexPaths(tableView.indexPathsForVisibleRows!, withRowAnimation: UITableViewRowAnimation.Fade)
                
                let indexPath = NSIndexPath(forRow: scrollRow, inSection: 0)
                tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Middle, animated: true)
                
                
            }
            
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 设置tableView
        tableView.separatorStyle = .None
        
        // 不然选中
        tableView.allowsSelection = false
        
        
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tableView.contentInset = UIEdgeInsetsMake(tableView.height * 0.5, 0, tableView.height * 0.5, 0)
    }
    
    
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataSource.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = QQLrcCell.cellWithTableView(tableView)
        
        
        if indexPath.row == scrollRow {
            cell.progress = progress
        }else {
            cell.progress = 0.0
        }
        
        
        // 1> 取出数据模型
        
        let lrcM =  dataSource[indexPath.row]
        
        // 2> 赋值
        cell.lrcStr = lrcM.lrcStr
        
        
        return cell
    }
    
    
    
}
