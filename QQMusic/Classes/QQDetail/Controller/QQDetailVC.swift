//
//  QQDetailVC.swift
//  QQMusic
//
//  Created by chen on 16/5/16.
//  Copyright © 2016年 chen. All rights reserved.
//

import UIKit

class QQDetailVC: UIViewController {

    //最里面的背景图片
    @IBOutlet weak var backImageView: UIImageView!
    
    //歌曲名称
    @IBOutlet weak var songNameLabel: UILabel!
    
    //歌手名称
    @IBOutlet weak var singerNameLabel: UILabel!
    
    //总时长
    @IBOutlet weak var totalTimeLabel: UILabel!
    
    //播放或者暂停按钮
    @IBOutlet weak var playOrPauseBtn: UIButton!
    
    //已经播放时长
    @IBOutlet weak var costTimeLabel: UILabel!
    
    //进度条
    @IBOutlet weak var progressSlider: UISlider!
    
    //歌词的背景图片,做动画使用
    @IBOutlet weak var lrcBackView: UIScrollView!
    
    //图片下边歌词的lable
    @IBOutlet weak var lrcLabel: UILabel!
    
    //前景图片
    @IBOutlet weak var foreImageView: UIImageView!
    
    
    //歌词视图
    lazy var lrcTVC: QQLrcTVC = {
    
        let tvc = QQLrcTVC()
        return tvc
    }()
    
    
    var lrcView : UIView?
    
    //定时器
    var timer: NSTimer?

}

//业务逻辑
extension QQDetailVC {

    //关闭
    @IBAction func close() {
        navigationController?.popViewControllerAnimated(true)
    }
    
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
        super.viewWillLayoutSubviews()
     setUpFrame()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        addTimer()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        removeTimer()
    }
    
}

//数据展示
extension QQDetailVC {

    //更新一次
    func setUpDataOnce() -> () {
        
        let musicMessageModel = QQMusicOperationTool.shareInstance.getNewMessageModel()
        
        //背景图片
        let imageName = musicMessageModel.musicM?.icon ?? ""
        backImageView.image = UIImage(named: imageName)
        //歌词名称
        songNameLabel.text = musicMessageModel.musicM?.name
        //歌手名称
        singerNameLabel.text = musicMessageModel.musicM?.singer
        //总时长
        totalTimeLabel.text = musicMessageModel.totalTimeFormat
        //播放或者暂停按钮
        
        //前景图片
        foreImageView.image = UIImage(named: imageName)
        
        //歌词数据源
        let lrcMs = QQLrcDataTool.getLrcData(musicMessageModel.musicM?.lrcname)
        
        
        addRotationAnimation()
        
        if musicMessageModel.isPlaying {
        resumeRotationAnimation()
        }else {
        pauseRotationAnimation()
        }
        
    }
    
    func setUpDataTimes() -> () {
        
        let musicMessageModel = QQMusicOperationTool.shareInstance.getNewMessageModel()
        
        costTimeLabel.text = musicMessageModel.costTimeFormat
        progressSlider.value = Float(musicMessageModel.constTime / musicMessageModel.totalTime)
        
        playOrPauseBtn.selected = musicMessageModel.isPlaying
    }
    
    //添加定时器
    func addTimer() -> () {
        timer = NSTimer(timeInterval: 1, target: self, selector: #selector(setUpDataTimes), userInfo: nil, repeats: true)
        //添加到RunLoop中
        NSRunLoop.currentRunLoop().addTimer(timer!, forMode: NSRunLoopCommonModes)
    }
    
    //移除定时器
    func removeTimer() -> () {
        timer?.invalidate()
        timer = nil
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

    func addRotationAnimation() -> () {
    
        foreImageView.layer.removeAnimationForKey("rotation")
        
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = M_PI * 2
        animation.duration = 30
        animation.repeatCount = MAXFLOAT
        
        animation.removedOnCompletion = false
        
        foreImageView.layer.addAnimation(animation, forKey: "rotation")
        
        
    }
    
    func pauseRotationAnimation() -> () {
        foreImageView.layer.pauseAnimate()
    }
    
    func resumeRotationAnimation() -> () {
        foreImageView.layer.resumeAnimate()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //获取滚动是X值
        //之后设置透明度
        let alpha = 1 - scrollView.contentOffset.x / scrollView.width
        
        foreImageView.alpha = alpha
        lrcLabel.alpha = alpha
    }
}

