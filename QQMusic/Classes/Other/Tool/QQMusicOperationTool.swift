//
//  QQMusicOperationTool.swift
//  QQMusic
//
//  Created by chen on 16/5/17.
//  Copyright © 2016年 chen. All rights reserved.
//

import UIKit
import MediaPlayer

class QQMusicOperationTool: NSObject {
    
    var drawRow: Int = -1
    
    private var artwork: MPMediaItemArtwork?
    
    private var musicMessageModel: QQMusicMessageModel = QQMusicMessageModel()
    
    
    // 提供最新信息
    func getNewMessageModel() -> QQMusicMessageModel {
        
        
        // 给属性赋值, 保证数据是最新的状态
        musicMessageModel.musicM = musicMList?[index]
        
        
        // 已经播放的时间
        musicMessageModel.costTime = tool.player?.currentTime ?? 0
        
        // 总时长
        musicMessageModel.totalTime = tool.player?.duration ?? 0
        
        // 播放状态
        musicMessageModel.isPlaying = tool.player?.playing ?? false
        
        return musicMessageModel
    }
    
    
    static let shareInstance = QQMusicOperationTool()
    
    // 记录当前正在播放的索引
    var index = 0 {
        didSet {
            if musicMList != nil
            {
                
                if index < 0
                {
                    index = musicMList!.count - 1
                }
                if index > musicMList!.count - 1 {
                    index = 0
                }
                
            }
        }
    }
    
    // 音乐播放列表
    var musicMList: [QQMusicModel]?
    
    
    let tool = QQMusicTool()
    
    func playMusic(musicM: QQMusicModel) -> () {
        
        let fileName = musicM.filename ?? ""
        
        tool.playMusic(fileName)
        
        if musicMList == nil {
            print("没有播放列表, 只能, 播放一首歌曲")
            return
        }
        
        index = (musicMList?.indexOf(musicM))!
        
    }
    
    func playCurrentMusic() -> () {
        tool.resumeCurrentMusic()
    }
    
    
    func pauseCurrentMusic() -> () {
        tool.pauseCurrentMusic()
    }
    
    
    // 下一首
    func nextMusic() -> () {
        
        index += 1
        
        if let tempList = musicMList {
            // 取出模型
            let musicM = tempList[index]
            // 根据模型, 播放音乐
            playMusic(musicM)
        }
        
        
        
    }
    
    // 上一首
    func preMusic() -> () {
        index -= 1
        
        if let tempList = musicMList {
            // 取出模型
            let musicM = tempList[index]
            // 根据模型, 播放音乐
            playMusic(musicM)
        }
    }
    
    
    
}


extension QQMusicOperationTool {
    
    
    func setUpLockMessage() -> () {
        
        
        print("设置锁屏信息")
        
        let musicMM = getNewMessageModel()
        
        
        // 展示锁屏信息
        
        // 1. 获取锁屏播放中心
        let playCenter = MPNowPlayingInfoCenter.defaultCenter()
        
        
        
        // 当前正在播放的歌词信息
        // 1. 根据当前的歌词文件名称, 获取所有的歌词数据模型列表
        let lrcMs = QQLrcDataTool.getLrcData(musicMM.musicM?.lrcname)
        // 2. 根据列表, 以及当前的播放时间, 获取当前的歌词数据模型
        let rowLrcM = QQLrcDataTool.getRowLrcM(musicMM.costTime, lrcMs: lrcMs)
        
        let lrcM = rowLrcM.lrcM
        
        
        
        // 1.1 创建一个字典
        let songName = musicMM.musicM?.name ?? ""
        let singerName = musicMM.musicM?.singer ?? ""
        let costTime = musicMM.costTime
        let totalTime = musicMM.totalTime
        
        if musicMM.musicM?.icon != nil
        {
            let image = UIImage(named: (musicMM.musicM?.icon)!)
            if image != nil
            {
                
                
                // 绘制新图片
                if drawRow != rowLrcM.row {
                    drawRow = rowLrcM.row
                    let newImage = QQImageTool.getNewImage(image!, str: lrcM.lrcStr)
                    //                    print("绘制了新图片")
                    artwork = MPMediaItemArtwork(image: newImage)
                }
                
                
                
            }
            
        }
        
        
        var infoDic: [String: AnyObject] = [
            
            // 歌曲名称
            MPMediaItemPropertyAlbumTitle: songName,
            
            // 演唱者
            MPMediaItemPropertyArtist: singerName,
            
            // 当前播放时间
            MPNowPlayingInfoPropertyElapsedPlaybackTime: costTime,
            
            // 总时长
            MPMediaItemPropertyPlaybackDuration: totalTime,
            
            // 专辑图片 MPMediaItemArtwork
            //            MPMediaItemPropertyArtwork: artwork
        ]
        if artwork != nil
        {
            infoDic[MPMediaItemPropertyArtwork] = artwork!
        }
        
        // 2. 给锁屏中心赋值
        
        playCenter.nowPlayingInfo = infoDic
        
        // 3. 接收远程事件
        UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
        
        
        
    }
    
    
    
}

















