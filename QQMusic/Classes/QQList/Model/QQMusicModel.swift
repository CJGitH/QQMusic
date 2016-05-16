//
//  QQMusicModel.swift
//  QQMusic
//
//  Created by chen on 16/5/16.
//  Copyright © 2016年 chen. All rights reserved.
//

import UIKit

class QQMusicModel: NSObject {
    
    
    /** 歌曲名称 */
    var name: String?
    
    /** 歌曲文件名称 */
    var filename: String?
    
    /** 歌词文件名称  */
    var lrcname: String?
    
    /** 演唱者 */
    var singer: String?
    
    /** 歌手头像 */
    var singerIcon: String?
    
    /** 专辑图片 */
    var icon: String?
    
    override init() {
        super.init()
    }
    
    init(dic: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dic)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    
    
    
    
}
