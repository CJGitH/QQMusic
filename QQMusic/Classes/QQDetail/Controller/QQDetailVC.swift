//
//  QQDetailVC.swift
//  QQMusic
//
//  Created by chen on 16/5/16.
//  Copyright © 2016年 chen. All rights reserved.
//

import UIKit


// 专门存放属性
class QQDetailVC: UIViewController {
    
    // 根据歌曲切换时, 不同属性的更新频率, 进行划分控件
    
    
    // 背景图片 1
    @IBOutlet weak var backImageView: UIImageView!
    // 歌曲名称 1
    @IBOutlet weak var songNameLabel: UILabel!
    // 歌手名称 1
    @IBOutlet weak var singerNameLabel: UILabel!
    // 总时长 1
    @IBOutlet weak var totalTimeLabel: UILabel!
    // 播放或者暂停按钮 待定
    @IBOutlet weak var playOrPauseBtn: UIButton!
    // 前景图片 1
    @IBOutlet weak var foreImageView: UIImageView!
    // 歌词的背景视图(做动画使用) 0
    @IBOutlet weak var lrcBackView: UIScrollView!
    
    
    
    // 已经播放时长 n
    @IBOutlet weak var costTimeLabel: UILabel!
    // 进度条 n
    @IBOutlet weak var progressSlider: UISlider!
    // 歌词的标签 n
    @IBOutlet weak var lrcLabel: QQLrcLabel!
    
    
    // 歌词视图
    
    lazy var lrcTVC: QQLrcTVC = {
        
        let tvc = QQLrcTVC()
        //        self.addChildViewController(tvc)
        return tvc
        
    }()
    
    
    var timer: NSTimer?
    
    
    var displayLink: CADisplayLink?
}

// 业务逻辑
extension QQDetailVC {
    
    @IBAction func close() {
        
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func playOrPause(sender: UIButton) {
        
        sender.selected = !sender.selected
        if sender.selected {
            QQMusicOperationTool.shareInstance.playCurrentMusic()
            resumeRotationAnimation()
        }else {
            QQMusicOperationTool.shareInstance.pauseCurrentMusic()
            pauseRotationAnimation()
        }
        
        
    }
    
    @IBAction func preMusic() {
        
        QQMusicOperationTool.shareInstance.preMusic()
        setUpDataOnce()
    }
    
    @IBAction func nextMusic() {
        QQMusicOperationTool.shareInstance.nextMusic()
        setUpDataOnce()
    }
    
    // 在视图加载好之后, 有可能, 里面拿到的不是真实的最终frame, 有可能是xib, 里面的大小
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewOnce()
        
    }
    
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        setUpFrame()
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        addTimer()
        addDisplayLink()
        setUpDataOnce()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        removeTimer()
        removeDisplayLink()
    }
    
    
    
    
}


// 数据展示
extension QQDetailVC {
    
    // 当歌曲切换时, 更新一次
    func setUpDataOnce() -> () {
        
        let musicMessageModel = QQMusicOperationTool.shareInstance.getNewMessageModel()
        
        // 背景图片 1
        let imageName = musicMessageModel.musicM?.icon ?? ""
        backImageView.image = UIImage(named: imageName)
        // 前景图片 1
        foreImageView.image = UIImage(named: imageName)
        
        // 歌曲名称 1
        songNameLabel.text = musicMessageModel.musicM?.name
        // 歌手名称 1
        singerNameLabel.text = musicMessageModel.musicM?.singer
        // 总时长 1
        totalTimeLabel.text = musicMessageModel.totalTimeFormat
        
        
        // 歌词数据源
        // 1. 获取歌词数据源
        let lrcMs = QQLrcDataTool.getLrcData(musicMessageModel.musicM?.lrcname)
        print(lrcMs)
        
        // 2. 交给歌词展示控制器, 来显示歌词
        lrcTVC.dataSource = lrcMs
        
        
        
        
        
        addRotationAnimation()
        
        if musicMessageModel.isPlaying {
            resumeRotationAnimation()
        }else {
            pauseRotationAnimation()
        }
        
        
    }
    
    // 1 秒
    func setUpDataTimes() -> () {
        
        let  musicMessageModel = QQMusicOperationTool.shareInstance.getNewMessageModel()
        
        costTimeLabel.text = musicMessageModel.costTimeFormat
        progressSlider.value = Float(musicMessageModel.costTime / musicMessageModel.totalTime)
        
        // 播放或者暂停按钮 待定
        playOrPauseBtn.selected = musicMessageModel.isPlaying
        
    }
    
    // 更新歌词(更新频率问题, 要求更新非常频繁)
    func updateLrc() -> () {
        
        let  musicMessageModel = QQMusicOperationTool.shareInstance.getNewMessageModel()
        
        // 1. 获取到滚动的行号
        let rowLrM = QQLrcDataTool.getRowLrcM(musicMessageModel.costTime, lrcMs: lrcTVC.dataSource)
        
        
        // 2. 交给歌词展示控制器, 来滚动
        let row = rowLrM.row
        lrcTVC.scrollRow = row
        
        // 3. 给歌词标签赋值
        let lrcM = rowLrM.lrcM
        lrcLabel.text = lrcM.lrcStr
        
        
        // 更新歌词进度
        let value = (musicMessageModel.costTime - lrcM.beginTime) / (lrcM.endTime - lrcM.beginTime)
        lrcLabel.progress = value
        
        lrcTVC.progress = value
        
        QQMusicOperationTool.shareInstance.setUpLockMessage()
    }
    
    
    func addTimer() -> () {
        timer = NSTimer(timeInterval: 1, target: self, selector: #selector(setUpDataTimes), userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(timer!, forMode: NSRunLoopCommonModes)
    }
    
    func removeTimer() -> () {
        timer?.invalidate()
        timer = nil
    }
    
    func addDisplayLink() -> () {
        
        displayLink = CADisplayLink(target: self, selector: #selector(updateLrc))
        
        displayLink?.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
        
    }
    
    func removeDisplayLink() -> () {
        displayLink?.invalidate()
        displayLink = nil
    }
    
    
    
}



// 界面处理
extension QQDetailVC {
    
    
    func setUpViewOnce() -> ()  {
        addLrcView()
        setUpSlider()
        
    }
    
    func setUpFrame() -> () {
        setUpForeImageView()
        setUpLrcViewFrame()
    }
    
    
    func setUpSlider() -> () {
        progressSlider.setThumbImage(UIImage(named: "player_slider_playback_thumb"), forState: UIControlState.Normal)
    }
    
    
    // 以后, 如果处理类似的问题
    // 分两步
    // 添加控件  1次  在执行一次的方法中调用
    // 布局  N次(准确说, 是执行多少次都没有关系的), 放到有可能不是一次的方法中执行
    func setUpLrcViewFrame() -> () {
        // 修改调整到争取的frame
        lrcTVC.tableView.frame = lrcBackView.bounds
        lrcTVC.tableView.x = lrcBackView.width
        lrcBackView.contentSize = CGSizeMake(lrcBackView.width * 2, 0)
    }
    
    // 负责添加控件1 次
    func addLrcView() -> () {
        // 1. 创建歌词视图
        
        
        lrcTVC.tableView.backgroundColor = UIColor.clearColor()
        
        // 2. 添加到滚动视图
        lrcBackView.addSubview((lrcTVC.tableView)!)
        lrcBackView.pagingEnabled = true
        lrcBackView.showsHorizontalScrollIndicator = false
        lrcBackView.delegate = self
        
    }
    
    
    
    // 设置圆角图片
    func setUpForeImageView() -> () {
        
        foreImageView.layer.cornerRadius = foreImageView.width * 0.5
        foreImageView.layer.masksToBounds = true
        
    }
    
    
    
    // 设置状态栏
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    
    
}


// 动画处理
extension QQDetailVC: UIScrollViewDelegate {
    
    func addRotationAnimation() -> () {
        
        // 1. 移除之前的动画
        foreImageView.layer.removeAnimationForKey("rotation")
        // 2. 重新添加动画
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = M_PI * 2
        animation.duration = 30
        animation.repeatCount = MAXFLOAT
        
        // 设置播放完成之后, 不移除
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
        
        let alpha = 1 - scrollView.contentOffset.x / scrollView.width
        
        
        
        // 设置透明度(0.0 - 1.0)
        foreImageView.alpha = alpha
        lrcLabel.alpha = alpha
        
    }
    
    
}


//运行在真机上,在后台播放时可以用
// 远程事件处理
extension QQDetailVC {
    
    
    override func remoteControlReceivedWithEvent(event: UIEvent?) {
        
        let type = (event?.subtype)!
        switch type {
        case .RemoteControlPlay:
            print("播放")
            QQMusicOperationTool.shareInstance.playCurrentMusic()
        case .RemoteControlPause:
            print("暂停")
            QQMusicOperationTool.shareInstance.pauseCurrentMusic()
        case .RemoteControlNextTrack:
            print("下一首")
            QQMusicOperationTool.shareInstance.nextMusic()
        case .RemoteControlPreviousTrack:
            print("上一首")
            QQMusicOperationTool.shareInstance.preMusic()
        default:
            print("不处理")
        }
        
        setUpDataOnce()
    }
    
}
