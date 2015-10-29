//
//  MessageTableViewCell.swift
//  TwitterClient
//
//  Created by nakazy on 2015/10/25.
//  Copyright © 2015年 nakazy. All rights reserved.
//

import UIKit

/// 吹き出しメッセージを生成する
/// MessageViewControllerもコードベースなのでCellもコードで記述
final class MessageTableViewCell: UITableViewCell {
    let messageLabelWidth: CGFloat = 220
    let rightBubbleMargin: CGFloat = 5
    
    /// TODO: 以下の数値は決め打ちになっているので、計算で求めるようにしたい。
    let verticalPadding: CGFloat = 20
    let horizontalMargin: CGFloat = 7
    let leftBubbleImageOriginX: CGFloat = 18
    let rightBubbleEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 20)
    let leftBubbleEdgeInsets = UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 15)
    
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

    /// 受け取ったメッセージの長さに応じて吹き出しを生成
    /// - parameter message: メッセージ
    func setupData(message: Message) {
        messageLabel.numberOfLines = 0
        messageLabel.lineBreakMode = .ByWordWrapping
        messageLabel.frame = CGRect(x: 10, y: 8, width: messageLabelWidth, height: 0)
        messageLabel.text = message.text
        messageLabel.font = UIFont.systemFontOfSize(13)
        messageLabel.sizeToFit()
        bubbleImageView.addSubview(messageLabel)
    
        switch message.type {
        case .Me:
            bubbleImageView.image = UIImage(named: "right_bubble")?
                .resizableImageWithCapInsets(rightBubbleEdgeInsets, resizingMode: UIImageResizingMode.Stretch)
            bubbleImageView.frame = CGRect(
                x: UIScreen.mainScreen().bounds.size.width - messageLabel.frame.size.width - messageLabel.frame.origin.x * 2 - rightBubbleMargin,
                y: 0,
                width: messageLabel.frame.size.width + messageLabel.frame.origin.x * 2 + horizontalMargin,
                height: messageLabel.frame.size.height + verticalPadding
            )
        case .Friend:
            messageLabel.frame.origin.x = leftBubbleImageOriginX
            bubbleImageView.image = UIImage(named: "left_bubble")?
                .resizableImageWithCapInsets(leftBubbleEdgeInsets, resizingMode: UIImageResizingMode.Stretch)
            bubbleImageView.frame = CGRect(
                x: 0,
                y: 0,
                width: messageLabel.frame.size.width + messageLabel.frame.origin.x * 2 - horizontalMargin,
                height: messageLabel.frame.size.height + verticalPadding
            )
        }
    }
}
