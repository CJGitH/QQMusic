//
//  QQMusicMessageModel.swift
//  QQMusic
//
//  Created by chen on 16/5/17.
//  Copyright © 2016年 chen. All rights reserved.
//

import UIKit

class QQMusicMessageModel: NSObject {

    //设置模型可以这样拥有,但不是继承,当其他类在使用这个模型时,就会同时拥有其他的模型
    var musicM: QQMusicModel?
    
    
    var costTime: NSTimeInterval = 0
    var totalTime: NSTimeInterval = 0
    var isPlaying: Bool = false
    
    
    
    var costTimeFormat: String {
        get {
        
            return QQTimeTool.getFormatTime(costTime)
        }
    }
    
    
    var totalTimeFormat: String {
        get {
        return QQTimeTool.getFormatTime(totalTime)
        }
    }
    
    
    
    
    
    
    
}
