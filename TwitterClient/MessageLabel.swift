//
//  MessageLabel.swift
//  TwitterClient
//
//  Created by nakazy on 2015/10/26.
//  Copyright © 2015年 nakazy. All rights reserved.
//

import UIKit

class MessageLabel: UILabel {
    let padding = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    init() {
        super.init(frame: CGRectZero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func drawTextInRect(rect: CGRect) {
        super.drawTextInRect(UIEdgeInsetsInsetRect(rect, padding))
    }
    
    override func intrinsicContentSize() -> CGSize {
        var intrinsicContentSize = super.intrinsicContentSize()
        intrinsicContentSize.height += padding.top + padding.bottom
        intrinsicContentSize.width += padding.left + padding.right
        return intrinsicContentSize
    }
}
