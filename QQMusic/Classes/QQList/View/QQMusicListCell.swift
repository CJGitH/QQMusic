//
//  QQMusicListCell.swift
//  QQMusic
//
//  Created by chen on 16/5/16.
//  Copyright © 2016年 chen. All rights reserved.
//

import UIKit

class QQMusicListCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
   
    @IBOutlet weak var singerNameLabel: UILabel!
    
    var musicM: QQMusicModel? {
        didSet {
            
            if musicM?.icon != nil {
                iconImageView.image = UIImage(named: (musicM?.icon)!)
            }
            
            songNameLabel.text = musicM?.name
            singerNameLabel.text = musicM?.singer
            
        }
    }
    
    
    class func cellWithTableView(tableView: UITableView) -> QQMusicListCell {
        
        let cellID = "musicList"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellID) as? QQMusicListCell
        if cell == nil {
            print("创建了cell")
            
            cell = NSBundle.mainBundle().loadNibNamed("QQMusicListCell", owner: nil , options: nil).first as? QQMusicListCell
        }
        
        
        return cell!
        
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        iconImageView.layer.cornerRadius = iconImageView.width * 0.5
        iconImageView.layer.masksToBounds = true
        
        
    }
    
    
    
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        
    }
    
}

