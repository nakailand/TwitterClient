//
//  MesseageViewController.swift
//  TwitterClient
//
//  Created by nakazy on 2015/10/25.
//  Copyright © 2015年 nakazy. All rights reserved.
//

import UIKit

/// メッセージを管理するクラス。動的にサイズが変わる部分が多いため、コードで実装している。
final class MessageViewController: UIViewController {
    let messageCellIdentifier = "MessageTableViewCell"
    let defaultCellHeight: CGFloat = 44
    let commentViewHeight: CGFloat = 44
    private var commentView: MessageView!
    private var tableView: UITableView!
    private var messages: [Message] = [] {
        didSet {
            tableView.reloadData()
            tableView.layoutIfNeeded()
        }
    }
    private var previousMessage: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTapGesture()
        setupKeyboardObserver()
        setupTableView()
        setupMessageView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: Private Methods
    private func setupTapGesture() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "closeKeyboard"))
    }
    
    private func setupKeyboardObserver() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidHide:", name: UIKeyboardDidHideNotification, object: nil)
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: self.view.bounds)
        tableView.frame.size.height -= commentViewHeight
        tableView.separatorColor = UIColor.clearColor()
        tableView.estimatedRowHeight = 70
        tableView.registerClass(MessageTableViewCell.self, forCellReuseIdentifier: messageCellIdentifier)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
    }
    
    private func setupMessageView() {
        commentView = MessageView(frame: CGRect(x: 0, y: self.view.bounds.height - commentViewHeight, width: self.view.bounds.width, height: commentViewHeight))
        commentView.postButton.addTarget(self, action: "postMessage", forControlEvents: .TouchUpInside)
        self.view.addSubview(commentView)
    }

    private func scrollToBottom() {
        if messages.isEmpty {
            return
        }
        
        let indexPath = NSIndexPath(
            forRow: self.tableView.numberOfRowsInSection(0) - 1,
            inSection: self.tableView.numberOfSections - 1
        )
        
        self.tableView.scrollToRowAtIndexPath(
            indexPath,
            atScrollPosition: UITableViewScrollPosition.Bottom,
            animated: true
        )
    }
    
    /// メッセージPost後の初期化処理
    private func resetCommentViewState() {
        commentView.textView.text.removeAll()
        commentView.postButton.enabled = false
        commentView.placeholderLabel.hidden = false
    }

    // MARK: Methods
    func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let keyboardRect = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue()
            if let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSTimeInterval {
                UIView.animateWithDuration(duration, animations: {
                    self.commentView.transform = CGAffineTransformMakeTranslation(0, -(self.view.bounds.height - keyboardRect!.origin.y))
                    self.tableView.frame.size.height = self.view.bounds.height - keyboardRect!.size.height - self.commentView.frame.size.height
                    self.scrollToBottom()
                })
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSTimeInterval {
                UIView.animateWithDuration(duration, animations: {
                    self.tableView.frame.size.height = self.view.bounds.height - self.commentView.frame.size.height
                    self.commentView.transform = CGAffineTransformIdentity
                })
            }
        }
    }
    
    func keyboardDidHide(notification: NSNotification) {
        if commentView.textView.text.isEmpty {
            commentView.postButton.enabled = false
        }
    }

    func closeKeyboard() {
        commentView.textView.resignFirstResponder()
    }
    
    func postMessage() {
        messages.append(Message(text: commentView.textView.text, type: .Me))
        previousMessage = commentView.textView.text
        resetCommentViewState()
        scrollToBottom()
        
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("reply"), userInfo: nil, repeats: false)
    }

    func reply() {
        messages.append(Message(text: " \(previousMessage) \(previousMessage)", type: .Friend))
        scrollToBottom()
    }
}

extension MessageViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
}

extension MessageViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("MessageTableViewCell") as? MessageTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .None
        cell.setupData(messages[indexPath.row])
        return cell
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return max(getMessageHeight(indexPath.row), defaultCellHeight)
    }
    
    /// 各メッセージの高さを取得
    /// - parameter row: テーブルの行
    private func getMessageHeight(row: Int) -> CGFloat {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 220, height: 0))
        messageLabel.numberOfLines = 0
        messageLabel.lineBreakMode = .ByWordWrapping
        messageLabel.text = messages[row].text
        messageLabel.font = UIFont.systemFontOfSize(13)
        messageLabel.sizeToFit()
        return messageLabel.frame.size.height + 20
    }
}
