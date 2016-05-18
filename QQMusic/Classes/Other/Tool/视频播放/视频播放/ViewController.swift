//
//  ViewController.swift
//  视频播放
//
//  Created by chen on 16/5/18.
//  Copyright © 2016年 chen. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    var player: AVPlayer?
    var layer: AVPlayerLayer?
    

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let url = NSURL(string: "http://v1.mukewang.com/19954d8f-e2c2-4c0a-b8c1-a4c826b5ca8b/L.mp4")
        
        player = AVPlayer(URL: url!)
        
        player?.play()
        
        //添加到layer上播放
        layer = AVPlayerLayer(player: player)
        layer?.frame = view.bounds
        view.layer.addSublayer(layer!)
        
    }
    
    //当点击停止时,就暂停视频播放
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        player?.pause()
    }
    
    //设置尺寸,在这里设置才zhunque
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        layer?.frame = view.bounds
    }
    

}

