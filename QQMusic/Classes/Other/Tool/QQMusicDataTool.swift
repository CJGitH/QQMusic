//
//  QQMusicDataTool.swift
//  QQMusic
//
//  Created by chen on 16/5/16.
//  Copyright © 2016年 chen. All rights reserved.
//

import UIKit

class QQMusicDataTool: NSObject {
    
    class func getMusicList(result: (musicMs: [QQMusicModel])->()) {
        
        // 从本地的plist文件加载
        // 1. 获取文件的路径
        guard let path = NSBundle.mainBundle().pathForResource("Musics.plist", ofType: nil) else {
            result(musicMs: [QQMusicModel]())
            return
        }
        
        // 2. 加载文件内容 dic array
        guard let dicArray = NSArray(contentsOfFile: path) else {
            result(musicMs: [QQMusicModel]())
            return
        }
        
        // 3. 把字典转成模型
        var resultMs = [QQMusicModel]()
        for dic in dicArray {
            
            let musicM = QQMusicModel(dic: dic as! [String: AnyObject])
            resultMs.append(musicM)
        }
        
        
        // 4. 返回出去
        result(musicMs: resultMs)
        
    }
    
    
    
}
