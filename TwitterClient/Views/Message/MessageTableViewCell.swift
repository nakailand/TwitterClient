//
//  MessageTableViewCell.swift
//  TwitterClient
//
//  Created by nakazy on 2015/10/25.
//  Copyright © 2015年 nakazy. All rights reserved.
//

import UIKit

// 吹き出しメッセージを生成する
final class MessageTableViewCell: UITableViewCell {
    let padding: CGFloat = 20
    private var messageLabel: UILabel!
    private var bubbleImageView: UIImageView!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        bubbleImageView = UIImageView()
        messageLabel = UILabel()
        self.addSubview(bubbleImageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // 受け取ったメッセージの長さに応じて吹き出しを生成
    func setupData(message: Message) {
        messageLabel.numberOfLines = 0
        messageLabel.lineBreakMode = .ByWordWrapping
        messageLabel.frame = CGRect(x: 10, y: 8, width: 220, height: 9999)
        messageLabel.text = message.text
        messageLabel.font = UIFont.systemFontOfSize(13)
        messageLabel.backgroundColor = UIColor.clearColor()
        messageLabel.sizeToFit()
        bubbleImageView.addSubview(messageLabel)
        switch message.type {
        case .Me:
            bubbleImageView.image = UIImage(named: "right_bubble")?.resizableImageWithCapInsets(UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 20), resizingMode: UIImageResizingMode.Stretch)
            bubbleImageView.frame = CGRect(x: UIScreen.mainScreen().bounds.size.width - messageLabel.frame.size.width - 30, y: 5, width: messageLabel.frame.size.width + 25, height: messageLabel.frame.size.height + padding)
        case .Friend:
            messageLabel.frame.origin.x = 15
            bubbleImageView.image = UIImage(named: "left_bubble")?.resizableImageWithCapInsets(UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 15), resizingMode: UIImageResizingMode.Stretch)
            bubbleImageView.frame = CGRect(x: 10, y: 7, width: messageLabel.frame.size.width + 30, height: messageLabel.frame.size.height + padding)
        }
    }
}
