//
//  MessageTableViewCell.swift
//  TwitterClient
//
//  Created by nakazy on 2015/10/25.
//  Copyright © 2015年 nakazy. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    @IBOutlet weak var messageLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func layoutSubviews() {
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setupData(message: Message) {
        let bubbleImageView = UIImageView()
        let messageLabel = UILabel(frame: CGRect(x: 10, y: 10, width: 220, height: 9999))
        messageLabel.numberOfLines = 0
        messageLabel.lineBreakMode = .ByWordWrapping
        messageLabel.text = message.text
        messageLabel.font = UIFont.systemFontOfSize(13)
        //messageLabel.backgroundColor = UIColor.purpleColor()
        //messageLabel.backgroundColor = UIColor.clearColor()
        messageLabel.sizeToFit()
        bubbleImageView.addSubview(messageLabel)
        switch message.type {
        case .Me:
            bubbleImageView.image = UIImage(named: "right_bubble")?.resizableImageWithCapInsets(UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15), resizingMode: UIImageResizingMode.Stretch)
            bubbleImageView.frame = CGRect(x: UIScreen.mainScreen().bounds.size.width - messageLabel.frame.size.width - 30, y: 0, width: messageLabel.frame.size.width + 30, height: messageLabel.frame.size.height + 20)
        case .Friend:
            bubbleImageView.image = UIImage(named: "left_bubble")?.resizableImageWithCapInsets(UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15), resizingMode: UIImageResizingMode.Stretch)
            bubbleImageView.frame = CGRect(x: 0, y: 0, width: messageLabel.frame.size.width + 30, height: messageLabel.frame.size.height + 20)
        }
        bubbleImageView.backgroundColor = UIColor.yellowColor()
        self.addSubview(bubbleImageView)
    }
}
