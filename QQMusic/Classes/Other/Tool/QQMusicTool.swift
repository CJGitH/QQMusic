//
//  QQMusicTool.swift
//  QQMusic
//
//  Created by chen on 16/5/17.
//  Copyright © 2016年 chen. All rights reserved.
//

import UIKit
import AVFoundation

class QQMusicTool: NSObject {
    
    override init() {
        super.init()
        
        // 1. 获取音频会话
        let session = AVAudioSession.sharedInstance()
        
        do {
            // 2. 设置音频会话类别
            try session.setCategory(AVAudioSessionCategoryPlayback)
            // 3. 激活会话
            try session.setActive(true)
        }catch {
            print(error)
            return
        }
        
    }
    
    
    var  player: AVAudioPlayer?
    
    func playMusic(name: String) {
        
        // 具体的播放实现
        // 1. 创建播放器
        guard let url = NSBundle.mainBundle().URLForResource(name, withExtension: nil) else {
            return
        }
        
        if url == player?.url {
            // 播放的是同一首歌曲
            player?.play()
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOfURL: url)
        }catch {
            print(error)
            return
        }
        
        // 2. 准备播放
        
        player?.prepareToPlay()
        
        // 3. 开始播放
        player?.play()
        
        
    }
    
    
    func pauseCurrentMusic() -> () {
        
        player?.pause()
        
    }
    
    func resumeCurrentMusic() -> () {
        player?.play()
    }
    
    
}
