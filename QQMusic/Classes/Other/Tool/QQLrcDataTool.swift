//
//  QQLrcDataTool.swift
//  QQMusic
//
//  Created by chen on 16/5/17.
//  Copyright © 2016年 chen. All rights reserved.
//

import UIKit

class QQLrcDataTool: NSObject {
    
    
    class func getRowLrcM(currentTime: NSTimeInterval, lrcMs: [QQLrcModel]) -> (row: Int, lrcM: QQLrcModel) {
        
        let count = lrcMs.count
        for i in 0..<count {
            
            let lrcM = lrcMs[i]
            
            if currentTime >= lrcM.beginTime && currentTime < lrcM.endTime {
                return (i, lrcM)
            }
            
        }
        
        return (0, QQLrcModel())
        
    }
    
    
    class func getLrcData(fileName: String?) -> [QQLrcModel] {
        
        // 解析歌词文件
        guard let path = NSBundle.mainBundle().pathForResource(fileName, ofType: nil)
            else {
                return [QQLrcModel]()
        }
        
        // 加载文件里面的内容(字符串)
        var lrcContent = ""
        do {
            
            lrcContent = try String(contentsOfFile: path)
        }catch {
            print(error)
            return [QQLrcModel]()
        }
        
        
        // 解析歌词内容, -> 数组(歌词数据模型)
        //        print(lrcContent)
        
        // 1. 转换成一行一行组成的数组
        let lrcStrArray = lrcContent.componentsSeparatedByString("\n")
        
        
        var lrcMs = [QQLrcModel]()
        
        // 处理成数据模型, 放到上面的数组里面去了
        for lrcStr in lrcStrArray {
            
            
            
            // 1. 过滤垃圾数据
            if lrcStr.containsString("[ti:") || lrcStr.containsString("[ar:") || lrcStr.containsString("[al:") {
                continue
            }
            
            
            let lrcM = QQLrcModel()
            lrcMs.append(lrcM)
            // 2. 拿到的是不是, 才是真正的可以解析的字符串
            // [00:00.89]传奇
            // 2.1 处理垃圾数据
            // 00:00.89]传奇
            let resultStr = lrcStr.stringByReplacingOccurrencesOfString("[", withString: "")
            
            // 2.2 真正开始解析
            let timeAndContent = resultStr.componentsSeparatedByString("]")
            if timeAndContent.count == 2 {
                // 00:00.89
                let time = timeAndContent[0]
                lrcM.beginTime = QQTimeTool.getTimeInterval(time)
                let content = timeAndContent[1]
                lrcM.lrcStr = content
            }
            
        }
        
        let count = lrcMs.count
        for i in 0..<count {
            if i != count - 1
            {
                lrcMs[i].endTime = lrcMs[i + 1].beginTime
            }
            
        }
        
        
        
        return lrcMs
        
        
    }
    
}

