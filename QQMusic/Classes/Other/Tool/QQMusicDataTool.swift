//
//  QQMusicDataTool.swift
//  QQMusic
//
//  Created by chen on 16/5/16.
//  Copyright © 2016年 chen. All rights reserved.
//

import UIKit

class QQMusicDataTool: NSObject {

    //把数据模型传进来,返回一个字典模型
    class func getMusicList(result: (musicMs: [QQMusicModel]) -> ()) {
        
        //从本地加载plist文件
       guard let path = NSBundle.mainBundle().pathForResource("Musics.plist", ofType: nil)
       else{
        result(musicMs: [QQMusicModel]())
        return
        }
        
        //加载文件内容
        guard let dicArray = NSArray(contentsOfFile: path) else {
        result(musicMs: [QQMusicModel]())
            return
        }
        
        //把字典转成模型
        var resultMs = [QQMusicModel]()
        for dic in dicArray {
        
            let musicM = QQMusicModel(dic: dic as! [String : AnyObject])
            resultMs.append(musicM)
        }
        
        //返回出去结果
        result(musicMs: resultMs)
        
    }
    
}
