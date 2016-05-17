//
//  QQTimeTool.swift
//  QQMusic
//
//  Created by chen on 16/5/17.
//  Copyright © 2016年 chen. All rights reserved.
//

import UIKit

class QQTimeTool: NSObject {

    //转换时间的格式
    class func getFormatTime(time: NSTimeInterval) -> String {
        
        let min = Int(time / 60)
        let sec = Int(time) % 60
        
        let resultStr = String(format: "%02d:%02d", min,sec)
        
        return resultStr
        
    }
}
