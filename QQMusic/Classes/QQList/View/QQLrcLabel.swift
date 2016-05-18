//
//  QQLrcLabel.swift
//  QQMusic
//
//  Created by chen on 16/5/18.
//  Copyright © 2016年 chen. All rights reserved.
//

import UIKit

class QQLrcLabel: UILabel {

    var progress: Double = 0.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        UIColor.greenColor().set()
        
        let progressFloat = CGFloat(progress)
        
        let fillRect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width * progressFloat, rect.size.height)
        
        UIRectFillUsingBlendMode(fillRect, .SourceIn)
        
    }
    
}
