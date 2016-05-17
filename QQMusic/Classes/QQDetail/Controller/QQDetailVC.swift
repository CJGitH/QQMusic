//
//  QQDetailVC.swift
//  QQMusic
//
//  Created by chen on 16/5/16.
//  Copyright © 2016年 chen. All rights reserved.
//

import UIKit

class QQDetailVC: UIViewController {

    //进度条
    @IBOutlet weak var progressSlider: UISlider!
    //歌词的背景图片,做动画使用
    @IBOutlet weak var lrcBackView: UIScrollView!
    
    //图片下边歌词的lable
    @IBOutlet weak var lrcLabel: UILabel!
    
    //前景图片
    @IBOutlet weak var foreImageView: UIImageView!
    
    
    
    var lrcView : UIView?

}

//业务逻辑
extension QQDetailVC {

    //播放按钮
    @IBAction func playOrPause(sender: UIButton) {
        sender.selected = !sender.selected
        if sender.selected {
        QQMusicOperationTool.shareInstance.playCurrentMusic()
        }else {
        QQMusicOperationTool.shareInstance.pauseCurrentMusic()
        }
        
    }
    
    //上一首
    @IBAction func preMusic() {
        QQMusicOperationTool.shareInstance.preMusic()
        
    }
    
    //下一首
    @IBAction func nextMusic(sender: UIButton) {
        
        QQMusicOperationTool.shareInstance.nextMusic()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewOnce()
        
    }
    
    
    //布局
    override func viewWillLayoutSubviews() {
     setUpFrame()
        
    }
    
}

//界面处理
extension QQDetailVC {
    
    func setUpViewOnce() -> () {
        addLrcView()
        setUpSlider()
    }
    
    func setUpFrame() -> () {
        setUpLrcViewFrame()
        setUpForeImageView()
    }
    
    
    func setUpLrcViewFrame() -> () {
        lrcView?.frame = lrcBackView.bounds
        
        lrcBackView.contentSize = CGSizeMake(lrcBackView.width * 2, 0)
        lrcView?.x = lrcBackView.width
        
    }
    
    //设置进度条的圆按钮
    func setUpSlider() -> () {
        progressSlider.setThumbImage(UIImage(named: "player_slider_playback_thumb"), forState: UIControlState.Normal)
    }
    
    func addLrcView() -> () {
        
        //创建歌词视图
        lrcView = UIView()
//        lrcView?.backgroundColor = UIColor.redColor()
        lrcBackView.pagingEnabled = true
        lrcBackView.addSubview(lrcView!)
        lrcBackView.showsHorizontalScrollIndicator = false
        lrcBackView.delegate = self
    }
    
    
    //设置圆角
    func setUpForeImageView() -> () {
        foreImageView.layer.cornerRadius = foreImageView.width * 0.5
        foreImageView.layer.masksToBounds = true
        
    }
    
    //设置状态栏
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}

//实现代理方法
extension QQDetailVC : UIScrollViewDelegate {

    func scrollViewDidScroll(scrollView: UIScrollView) {
        //获取滚动是X值
        //之后设置透明度
        let alpha = 1 - scrollView.contentOffset.x / scrollView.width
        
        foreImageView.alpha = alpha
        lrcLabel.alpha = alpha
    }
}

