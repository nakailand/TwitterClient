//
//  FollowerListTableView.swift
//  TwitterClient
//
//  Created by nakazy on 2015/10/27.
//  Copyright © 2015年 nakazy. All rights reserved.
//

import UIKit

// Follower情報を表示するセル
final class FollowerListTableViewCell: UITableViewCell {
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func layoutSubviews() {
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
