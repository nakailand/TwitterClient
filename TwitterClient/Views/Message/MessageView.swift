//
//  MessageView.swift
//  TwitterClient
//
//  Created by nakazy on 2015/10/28.
//  Copyright © 2015年 nakazy. All rights reserved.
//

import UIKit

// TextView, PostButtonが載るView
final class MessageView: UIView {
    init() {
        super.init(frame: CGRectZero)
    }
    let postButtonWidth: CGFloat = 96
    let margin: CGFloat = 4
    let bgColor = UIColor(red: 247.0/255, green: 247.0/255, blue: 247.0/255, alpha: 1.0) /// navigationBarの色と同じ
    let buttonTitleColorForNormal = UIColor(red: 0, green: 0.478431, blue: 1, alpha: 1)
    let buttonTitleColorForDisabled = UIColor.grayColor()
    let buttonTitleForNormal = "Post"
    let placeholderLabelText = "メッセージ"
    
    var postButton: UIButton!
    var placeholderLabel: UILabel!
    private(set) var textView: UITextView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = bgColor
        
        setupPostButton()
        setupTextView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupPostButton() {
        postButton = UIButton(frame: CGRect(
            x: self.bounds.width - postButtonWidth - margin,
            y: margin,
            width: postButtonWidth,
            height: self.bounds.size.height - margin * 2)
        )
        postButton.setTitle(buttonTitleForNormal, forState: .Normal)
        postButton.setTitleColor(buttonTitleColorForNormal, forState: .Normal)
        postButton.setTitleColor(buttonTitleColorForDisabled, forState: .Disabled)
        postButton.enabled = false
        self.addSubview(postButton)
    }
    
    private func setupTextView() {
        textView = UITextView(frame: CGRect(
            x: margin,
            y: margin,
            width: self.bounds.width - postButtonWidth - margin * 3,
            height: self.bounds.size.height - margin * 2)
        )
        textView.delegate = self
        setupPlaceholderLabel()
        self.addSubview(textView)
        textView.addSubview(placeholderLabel)
    }
    
    private func setupPlaceholderLabel() {
        placeholderLabel = UILabel()
        let caretRect = textView.caretRectForPosition(textView.beginningOfDocument)
        placeholderLabel.frame.origin = caretRect.origin
        placeholderLabel.frame.size.height = caretRect.size.height
        placeholderLabel.baselineAdjustment = .AlignCenters
        placeholderLabel.textColor = UIColor.lightGrayColor()
        placeholderLabel.font = UIFont.systemFontOfSize(13)
        placeholderLabel.text = placeholderLabelText
        placeholderLabel.sizeToFit()
        print(placeholderLabel.frame)
    }
}

extension MessageView: UITextViewDelegate {
    func textViewDidBeginEditing(textView: UITextView) {
        postButton.enabled = !textView.text.isEmpty
    }
    
    func textViewDidChange(textView: UITextView) {
        postButton.enabled = !textView.text.isEmpty
        placeholderLabel.hidden = !textView.text.isEmpty
    }
}
