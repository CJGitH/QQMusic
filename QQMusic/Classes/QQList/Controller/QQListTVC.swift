//
//  QQListTVC.swift
//  QQMusic
//
//  Created by chen on 16/5/16.
//  Copyright © 2016年 chen. All rights reserved.
//

import UIKit

class QQListTVC: UITableViewController {
    
    
    var musicMs: [QQMusicModel] = [QQMusicModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 界面操作
        setUpInit()
        
        // 需要数据 -> 展示
        
        // 数据怎么获取, 抽成一个工具类
        // 好处: 重用性高,
        
        QQMusicDataTool.getMusicList { (musicMs) in
            
            // 展示数据
            print(musicMs)
            self.musicMs = musicMs
            
        }
    }
    
    
    
    
    
}


// 数据展示
extension QQListTVC {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicMs.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = QQMusicListCell.cellWithTableView(tableView)
        
        // 取出模型
        let musicM = musicMs[indexPath.row]
        cell.musicM = musicM
        
        return cell
        
        
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        //开始做动画
        let currentcell = cell as! QQMusicListCell
        currentcell.beginAnimation(AnimatonType.Rotation)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //拿到数据模型
        let musicM = musicMs[indexPath.row]
        
        //根据数据模型,播放音乐
        QQMusicOperationTool.shareInstance.playMusic(musicM)
        
    }
    
}

// 界面搭建
extension QQListTVC {
    
    
    // 提供一个统一界面设置的方法, 供外界调用
    private func setUpInit() {
        
        setUpTableView()
        setUpNavigationBar()
        
    }
    
    
    private func setUpTableView() -> () {
        let backView = UIImageView(image: UIImage(named: "QQListBack.jpg"))
        tableView.backgroundView = backView
        
        tableView.rowHeight = 60
        
        tableView.separatorStyle = .None
    }
    
    private func setUpNavigationBar() -> () {
        navigationController?.navigationBarHidden = true
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
}

