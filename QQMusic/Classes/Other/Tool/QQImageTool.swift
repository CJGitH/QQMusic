//
//  QQImageTool.swift
//  QQMusic
//
//  Created by chen on 16/5/18.
//  Copyright © 2016年 chen. All rights reserved.
//

import UIKit

class QQImageTool: NSObject {
    
    class func getNewImage(sourceImage: UIImage, str: String) -> UIImage {
        
        
        let size = sourceImage.size
        // 1. 开启图形上下文
        UIGraphicsBeginImageContext(size)
        
        // 2. 绘制大的图片
        sourceImage.drawInRect(CGRectMake(0, 0, size.width, size.height))
        
        
        // 3. 绘制文字
        let style: NSMutableParagraphStyle = NSMutableParagraphStyle()
        style.alignment = .Center
        let dic: [String : AnyObject] = [
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSParagraphStyleAttributeName: style,
            NSFontAttributeName: UIFont.systemFontOfSize(20)
        ]
        (str as NSString).drawInRect(CGRectMake(0, 0, size.width, 26), withAttributes: dic)
        
        // 4. 获取结果图片
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // 5. 关闭上下文
        UIGraphicsEndImageContext()
        
        
        // 6. 返回结果
        return resultImage
        
        
        
    }
    
    
}