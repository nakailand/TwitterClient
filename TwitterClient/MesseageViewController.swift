//
//  MesseageViewController.swift
//  TwitterClient
//
//  Created by nakazy on 2015/10/25.
//  Copyright © 2015年 nakazy. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {
    @IBOutlet weak var commentView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textView: UITextView!
    private var messages: [Message] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    let messageCellIdentifier = "MessageTableViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        self.view.backgroundColor = UIColor.redColor()
        let tap = UITapGestureRecognizer(target: self, action: "tap")
        self.view.addGestureRecognizer(tap)

        tableView.separatorColor = UIColor.clearColor()
        tableView.estimatedRowHeight = 90
        tableView.registerClass(MessageTableViewCell.self, forCellReuseIdentifier: messageCellIdentifier)
        tableView.rowHeight = UITableViewAutomaticDimension
        messages = []
        messages.append(Message(text: "aaaaaa", type: .Me))
        messages.append(Message(text: "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB", type: .Friend))
        messages.append(Message(text: "aaaaaa", type: .Me))
        messages.append(Message(text: "BBBBBB", type: .Friend))
        messages.append(Message(text: "aaaaaa", type: .Me))
        messages.append(Message(text: "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB", type: .Friend))
        messages.append(Message(text: "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB", type: .Friend))
        messages.append(Message(text: "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB", type: .Friend))
        messages.append(Message(text: "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB", type: .Friend))
        messages.append(Message(text: "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB", type: .Friend))
        messages.append(Message(text: "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB", type: .Friend))
        messages.append(Message(text: "BBBBBB", type: .Friend))
        messages.append(Message(text: "aaaaaa", type: .Me))
        messages.append(Message(text: "BBBBBB", type: .Friend))
        messages.append(Message(text: "aaaaaa", type: .Me))
        messages.append(Message(text: "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB", type: .Friend))
        messages.append(Message(text: "BBBBBB", type: .Friend))
        messages.append(Message(text: "aaaaaa", type: .Me))
        messages.append(Message(text: "BBBBBB", type: .Friend))
        messages.append(Message(text: "aaaaaa", type: .Me))
        messages.append(Message(text: "BBBBBB", type: .Friend))
        messages.append(Message(text: "aaaaaa", type: .Me))
        messages.append(Message(text: "BBBBBB", type: .Friend))
        messages.append(Message(text: "aaaaaa", type: .Me))
        messages.append(Message(text: "BBBBBB", type: .Friend))
        messages.append(Message(text: "aaaaaa", type: .Me))
        messages.append(Message(text: "BBBBBB", type: .Friend))
        messages.append(Message(text: "aaaaaa", type: .Me))
        messages.append(Message(text: "BBBBBB", type: .Friend))
        messages.append(Message(text: "aaaaaa", type: .Me))
        messages.append(Message(text: "BBBBBB", type: .Friend))
        messages.append(Message(text: "aaaaaa", type: .Me))
        messages.append(Message(text: "BBBBBB", type: .Friend))
        messages.append(Message(text: "aaaaaa", type: .Me))
        messages.append(Message(text: "BBBBBB", type: .Friend))
        messages.append(Message(text: "aaaaaa", type: .Me))
        messages.append(Message(text: "BBBBBB", type: .Friend))
        messages.append(Message(text: "aaaaaa", type: .Me))
        messages.append(Message(text: "BBBBBB", type: .Friend))
        messages.append(Message(text: "aaaaaa", type: .Me))
        messages.append(Message(text: "BBBBBB", type: .Friend))
        messages.append(Message(text: "aaaaaa", type: .Me))
        messages.append(Message(text: "BBBBBB", type: .Friend))
        messages.append(Message(text: "aaaaaa", type: .Me))
        messages.append(Message(text: "BBBBBB", type: .Friend))
        messages.append(Message(text: "aaaaaa", type: .Me))
        messages.append(Message(text: "BBBBBB", type: .Friend))
        messages.append(Message(text: "aaaaaa", type: .Me))
        messages.append(Message(text: "BBBBBB", type: .Friend))
        messages.append(Message(text: "aaaaaa", type: .Me))
        messages.append(Message(text: "BBBBBB", type: .Friend))
        messages.append(Message(text: "aaaaaa", type: .Me))
        messages.append(Message(text: "BBBBBB", type: .Friend))
        messages.append(Message(text: "aaaaaa", type: .Me))
        messages.append(Message(text: "BBBBBB", type: .Friend))
        messages.append(Message(text: "aaaaaa", type: .Me))
        messages.append(Message(text: "BBBBBB", type: .Friend))
        messages.append(Message(text: "aaaaaa", type: .Me))
        messages.append(Message(text: "BBBBBB", type: .Friend))
        tableView.reloadData()
    }
    
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
                    self.tableView.transform = CGAffineTransformMakeTranslation(0, -(self.view.bounds.height - keyboardRect!.origin.y))
                    let indexPath = NSIndexPath(
                        forRow: self.tableView.numberOfRowsInSection(0) - 1,
                        inSection: self.tableView.numberOfSections - 1
                    )
                    self.tableView.scrollToRowAtIndexPath(
                        indexPath,
                        atScrollPosition: UITableViewScrollPosition.Bottom,
                        animated: true
                    )
                })
            }
        }
    }

    func keyboardWillHide(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSTimeInterval {
                UIView.animateWithDuration(duration, animations: {
                    self.tableView.transform = CGAffineTransformIdentity
                    self.commentView.transform = CGAffineTransformIdentity
                })
            }
        }
    }

    func tap() {
        textView.resignFirstResponder()
    }
    
    @IBAction func postMessage(sender: AnyObject) {
        messages.append(Message(text: textView.text, type: .Me))
        let indexPath = NSIndexPath(forRow: self.tableView.numberOfRowsInSection(0) - 1,
            inSection: self.tableView.numberOfSections - 1)
        self.tableView.scrollToRowAtIndexPath(indexPath,
            atScrollPosition: UITableViewScrollPosition.Bottom,
            animated: true)

        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("someMethod"), userInfo: nil, repeats: false)

    }

    func someMethod() {
        messages.append(Message(text: " \(textView.text) \(textView.text)", type: .Friend))
        let index = NSIndexPath(forRow: self.tableView.numberOfRowsInSection(0) - 1,
            inSection: self.tableView.numberOfSections - 1)
        self.tableView.scrollToRowAtIndexPath(index,
            atScrollPosition: UITableViewScrollPosition.Bottom,
            animated: true)
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
        print(messageLabel.frame.size.height)
        return max(messageLabel.frame.size.height + 30, 44)
    }
}

extension MessageViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        textView.resignFirstResponder()
    }
}
