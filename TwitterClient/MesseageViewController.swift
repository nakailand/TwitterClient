//
//  MesseageViewController.swift
//  TwitterClient
//
//  Created by nakazy on 2015/10/25.
//  Copyright © 2015年 nakazy. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {
    ///@IBOutlet weak var commentView: UIView!
    ///@IBOutlet weak var postButton: UIButton!
    ///
    ///@IBOutlet weak var tableView: UITableView!
    ///@IBOutlet weak var textView: UITextView!
    var commentView: UIView!
    var postButton: UIButton!
    var tableView: UITableView!
    var textView: UITextView!
    private var messages: [Message] = [] {
        didSet {
            tableView.reloadData()
            tableView.layoutIfNeeded()
        }
    }
    private var diff: CGFloat = 0.0
    private var keyboardHeight: CGFloat = 0
    let messageCellIdentifier = "MessageTableViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidHide:", name: UIKeyboardDidHideNotification, object: nil)
        let tap = UITapGestureRecognizer(target: self, action: "tap")
        self.view.addGestureRecognizer(tap)
        tableView = UITableView(frame: self.view.bounds)
        tableView.frame.size.height -= 44
        tableView.separatorColor = UIColor.clearColor()
        tableView.estimatedRowHeight = 70
        tableView.registerClass(MessageTableViewCell.self, forCellReuseIdentifier: messageCellIdentifier)
        tableView.rowHeight = UITableViewAutomaticDimension
        
        commentView = UIView(frame: CGRect(x: 0, y: self.view.bounds.height - 44, width: self.view.bounds.width, height: 44))
        commentView.backgroundColor = UIColor.grayColor()
        
        postButton = UIButton(frame: CGRect(x: self.view.bounds.width - 100, y: 4, width: 96, height: 36))
        postButton.setTitle("Post", forState: .Normal)
        postButton.backgroundColor = UIColor.redColor()
        postButton.addTarget(self, action: "postMessage", forControlEvents: .TouchUpInside)
        postButton.enabled = false
        
        textView = UITextView(frame: CGRect(x: 4, y: 4, width: self.view.bounds.width - 108, height: 36))
        textView.backgroundColor = UIColor.blueColor()
        textView.delegate = self
        commentView.addSubview(textView)
        commentView.addSubview(postButton)
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(commentView)
    }
    private var sum: CGFloat = 0
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let keyboardRect = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue()
            if let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSTimeInterval {
                UIView.animateWithDuration(duration, animations: {
                    self.commentView.transform = CGAffineTransformMakeTranslation(0, -(self.view.bounds.height - keyboardRect!.origin.y))
                    self.diff = self.view.bounds.height - keyboardRect!.origin.y
                    self.keyboardHeight = keyboardRect!.size.height
                    self.tableView.frame.size.height = self.view.bounds.height - keyboardRect!.size.height - self.commentView.frame.size.height
                    if self.messages.count > 0 {
                        //self.tableView.transform = CGAffineTransformMakeTranslation(0, -(self.view.bounds.height - keyboardRect!.origin.y))
                        //self.tableView.transform = CGAffineTransformMakeScale(1.0, 0.6)
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
        postButton.enabled = false
    }

    func tap() {
        textView.resignFirstResponder()
    }
    
    func postMessage() {
        print("beforeMess")
        print(self.tableView.contentSize)
        print(textView.text)
        messages.append(Message(text: textView.text, type: .Me))
        print("contentsize")
        print(self.tableView.contentSize)
        print("contentsize")
        print(self.tableView.contentSize)
        me()
        
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("someMethod"), userInfo: nil, repeats: false)

    }

    func someMethod() {
        messages.append(Message(text: " \(textView.text) \(textView.text)", type: .Friend))
        me()
    }
    
    func me() {
        //if self.tableView.contentSize.height > self.tableView.frame.size.height {
            //self.tableView.transform = CGAffineTransformMakeTranslation(0, -(self.view.bounds.height - diff))
            self.tableView.setContentOffset(CGPoint(x: 0, y: self.tableView.contentSize.height - self.tableView.frame.size.height), animated: true)
            let indexPath = NSIndexPath(
                forRow: self.tableView.numberOfRowsInSection(0) - 1,
                inSection: self.tableView.numberOfSections - 1
            )
            self.tableView.scrollToRowAtIndexPath(
                indexPath,
                atScrollPosition: UITableViewScrollPosition.Bottom,
                animated: true
            )
        //}
        //if self.messages.count > 0 && (self.tableView.contentSize.height > diff) {
        //    //if  self.tableView.contentSize.height > self.view.bounds.height {
        //        self.tableView.transform = CGAffineTransformMakeTranslation(0, -diff)
        //        let indexPath = NSIndexPath(
        //            forRow: self.tableView.numberOfRowsInSection(0) - 1,
        //            inSection: self.tableView.numberOfSections - 1
        //        )
        //        self.tableView.scrollToRowAtIndexPath(
        //            indexPath,
        //            atScrollPosition: UITableViewScrollPosition.Bottom,
        //            animated: true
        //        )
        //    //}
        //}
        //else {
        //  self.tableView.transform = CGAffineTransformMakeTranslation(0, -(self.tableView.contentSize.height - (keyboardHeight + commentView.frame.size.height)))
        //  let indexPath = NSIndexPath(
        //      forRow: self.tableView.numberOfRowsInSection(0) - 1,
        //      inSection: self.tableView.numberOfSections - 1
        //  )
        //  self.tableView.scrollToRowAtIndexPath(
        //      indexPath,
        //      atScrollPosition: UITableViewScrollPosition.Bottom,
        //      animated: true
        //  )
        //  
        //}
    }
}

extension MessageViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //let messageViewController = UIStoryboard(name: "MessageViewController", bundle: nil).instantiateInitialViewController() as! MessageViewController
        //self.navigationController?.pushViewController(messageViewController, animated: true)
    }
}

extension MessageViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("MessageTableViewCell") as? MessageTableViewCell else {
            return UITableViewCell()
        }
        cell.setupData(messages[indexPath.row])
        return cell
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let messageLabel = UILabel(frame: CGRect(x: 15, y: 10, width: 220, height: 9999))
        messageLabel.numberOfLines = 0
        messageLabel.lineBreakMode = .ByWordWrapping
        messageLabel.text = messages[indexPath.row].text
        messageLabel.font = UIFont.systemFontOfSize(13)
        messageLabel.sizeToFit()
        return max(messageLabel.frame.size.height + 30, 44)
    }
}

extension MessageViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        //textView.resignFirstResponder()
    }
}

extension MessageViewController: UITextViewDelegate {
    func textViewDidBeginEditing(textView: UITextView) {
        postButton.enabled = !textView.text.isEmpty
    }
    
    func textViewDidChange(textView: UITextView) {
        postButton.enabled = !textView.text.isEmpty
    }
}

