//
//  QQListTVC.swift
//  QQMusic
//
//  Created by chen on 16/5/16.
//  Copyright © 2016年 chen. All rights reserved.
//

import UIKit

class QQListTVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //设置界面
        setUpInit()
        
        QQMusicDataTool.getMusicList { (musicMs) in
            
            print(musicMs)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}

//数据显示
extension QQListTVC {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    
}

//界面搭建
extension QQListTVC {

    //提供一个方法用于设置界面搭建
   private func setUpInit() -> () {
        setUpTableView()
        setUpNavigationBar()
    }
    
    //设置背景色
    private func setUpTableView() -> () {
    
        let backView = UIImageView(image: UIImage(named: "QQListBack.jpg"))
        
        tableView.backgroundView = backView
        
    }
    
    //设置navbar
    private func setUpNavigationBar() -> () {
        navigationController?.navigationBarHidden = true
    }
    
    //取消点击高亮状态
     override func preferredStatusBarStyle() -> UIStatusBarStyle {
    
    return .LightContent
    }
}


