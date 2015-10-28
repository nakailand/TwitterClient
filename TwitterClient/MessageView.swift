//
//  MessageView.swift
//  TwitterClient
//
//  Created by nakazy on 2015/10/28.
//  Copyright © 2015年 nakazy. All rights reserved.
//

import UIKit

// TextView, PostButtonが載るView
class MessageView :UIView {
    init() {
        super.init(frame: CGRectZero)
    }
    
    var postButton: UIButton!
    private(set) var textView: UITextView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 247.0/255, green: 247.0/255, blue: 247.0/255, alpha: 1.0)
        
        postButton = UIButton(frame: CGRect(x: self.bounds.width - 100, y: 4, width: 96, height: 36))
        postButton.setTitle("Post", forState: .Normal)
        postButton.setTitleColor(UIColor(red: 0, green: 0.478431, blue: 1, alpha: 1), forState: .Normal)
        postButton.setTitleColor(UIColor.grayColor(), forState: .Disabled)
        postButton.enabled = false
        
        textView = UITextView(frame: CGRect(x: 4, y: 4, width: self.bounds.width - 108, height: 36))
        textView.delegate = self
        self.addSubview(textView)
        self.addSubview(postButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension MessageView: UITextViewDelegate {
    func textViewDidBeginEditing(textView: UITextView) {
        postButton.enabled = !textView.text.isEmpty
    }
    
    func textViewDidChange(textView: UITextView) {
        postButton.enabled = !textView.text.isEmpty
    }
}