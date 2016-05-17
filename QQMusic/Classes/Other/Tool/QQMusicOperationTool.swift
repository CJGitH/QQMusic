//
//  QQMusicOperationTool.swift
//  QQMusic
//
//  Created by chen on 16/5/17.
//  Copyright © 2016年 chen. All rights reserved.
//

import UIKit

class QQMusicOperationTool: NSObject {
    
    
    static let shareInstance = QQMusicOperationTool()
    
    // 记录当前正在播放的索引
    var index = 0 {
        didSet {
            if index < 0
            {
                index = (musicMList?.count ?? 0) - 1
            }
            if index > (musicMList?.count ?? 0) - 1 {
                index = 0
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




















