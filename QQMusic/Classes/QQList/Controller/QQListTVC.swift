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
            
            self.musicMs = musicMs
            
            //给播放工具类进行复制播放列表
            QQMusicOperationTool.shareInstance.musicMList = musicMs
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
        
        
        //跳转到下一个控制器
        performSegueWithIdentifier("listToDetail", sender: nil)
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        
        guard let indexPaths = tableView.indexPathsForVisibleRows else {
        
            return
        }
        
        //计算中间一行对应的索引
        let first = indexPaths.first?.row ?? 0
        let last = indexPaths.last?.row ?? 0
        
        let middle = Int(Float(first + last) * 0.5)
        
        for indexPath in indexPaths {
        
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            
            cell?.x = CGFloat(abs(indexPath.row - middle) * 20)
        }
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

