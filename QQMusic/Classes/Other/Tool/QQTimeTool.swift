//
//  QQTimeTool.swift
//  QQMusic
//
//  Created by chen on 16/5/17.
//  Copyright © 2016年 chen. All rights reserved.
//

import UIKit

class QQTimeTool: NSObject {
    
    class func getFormatTime(time: NSTimeInterval) -> String {
        
        // time 123
        // 03:12
        
        let min = Int(time / 60)
        let sec = Int(time) % 60
        
        
        let resultStr = String(format: "%02d:%02d", min, sec)
        
        
        return resultStr
    }
    
    
    class func getTimeInterval(formatTime: String) -> NSTimeInterval {
        
        //  00:00.89  -> 多少秒
        
        let minAndSec = formatTime.componentsSeparatedByString(":")
        if minAndSec.count == 2 {
            // 分钟
            let min = NSTimeInterval(minAndSec[0]) ?? 0
            // 秒数
            let sec = NSTimeInterval(minAndSec[1]) ?? 0
            return min * 60 + sec
        }
        
        return 0
        
    }
    
    
    
    
    
    
}
