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

    var player : AVAudioPlayer?
    
    func playMusic(name : String){
        guard let url = NSBundle.mainBundle().URLForResource(name, withExtension: nil)
            else {
        return
        }
        
        if url == player?.url {
        player?.play()
            return
        }
        
        do {
        player = try AVAudioPlayer(contentsOfURL: url)
            
        }catch {
        
            return
        }
        
        player?.prepareToPlay()
        
        player?.play()
    }
    
    func pauseCurrentMusic() -> () {
        player?.pause()
    }
    
    func resumeCurrentMusic() -> () {
        player?.play()
    }
    
}
