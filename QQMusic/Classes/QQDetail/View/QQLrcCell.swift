//
//  QQLrcCell.swift
//  QQMusic
//
//  Created by chen on 16/5/17.
//  Copyright © 2016年 chen. All rights reserved.
//

import UIKit

class QQLrcCell: UITableViewCell {

    @IBOutlet weak var lrcContentLabel: QQLrcLabel!
    
    
    var progress: Double = 0.0 {
        didSet {
            lrcContentLabel.progress = progress
        }
    }
    
    var lrcStr: String = "" {
        didSet {
            
            lrcContentLabel.text = lrcStr
            
        }
    }
    
    
    
    class func cellWithTableView(tableView: UITableView) -> QQLrcCell {
        
        let cellID = "lrc"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellID) as? QQLrcCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("QQLrcCell", owner: nil, options: nil).first as? QQLrcCell
        }
        return cell!
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
