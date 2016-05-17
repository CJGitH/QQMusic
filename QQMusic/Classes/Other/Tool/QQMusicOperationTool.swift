//
//  QQMusicOperationTool.swift
//  QQMusic
//
//  Created by chen on 16/5/17.
//  Copyright © 2016年 chen. All rights reserved.
//

import UIKit

class QQMusicOperationTool: NSObject {

    //创建一个单例
    static let shareInstance = QQMusicOperationTool()
    
    let tool = QQMusicTool()
    
    func playMusic(music: QQMusicModel) -> () {
        
        let fileName = music.filename ?? ""
        
        tool.playMusic(fileName)
        
        
    }
    
}
