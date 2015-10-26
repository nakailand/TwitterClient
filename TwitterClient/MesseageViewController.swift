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
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidShow:", name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidHide:", name: UIKeyboardDidHideNotification, object: nil)
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
                    //self.commentView.frame.origin.y = keyboardRect!.origin.y - self.commentView.frame.size.height
                    self.commentView.transform = CGAffineTransformMakeTranslation(0, -(self.view.bounds.height - keyboardRect!.origin.y))
                    self.tableView.transform = CGAffineTransformMakeTranslation(0, -(self.view.bounds.height - keyboardRect!.origin.y))
                    //if self.tableView.contentSize.height > self.tableView.frame.size.height {
                    //    self.tableView.setContentOffset(CGPoint(x: 0, y: self.tableView.contentSize.height - self.tableView.frame.size.height), animated: true)
                    //    print(self.tableView.contentSize.height - self.tableView.frame.size.height)
                    //    print(self.tableView.contentSize.height)
                    //    print(self.tableView.frame.size.height)
                    //}
                    let indexPath = NSIndexPath(forRow: self.tableView.numberOfRowsInSection(0) - 1,
                        inSection: self.tableView.numberOfSections - 1)
                    self.tableView.scrollToRowAtIndexPath(indexPath,
                        atScrollPosition: UITableViewScrollPosition.Bottom,
                        animated: true)
                    //self.tableView.scrollToRowAtIndexPath(
                    //    NSIndexPath(forRow: self.tableView.numberOfRowsInSection(self.tableView.numberOfSections - 1),
                    //    inSection: self.tableView.numberOfSections - 1),
                    //    atScrollPosition: .Bottom,
                    //    animated: true
                    //)
                })
            }
        }
    }

    func keyboardDidShow(notification: NSNotification) {
        //self.tableView.setContentOffset(CGPoint(x: 0, y: self.tableView.contentSize.height - self.tableView.frame.size.height), animated: true)
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

    func keyboardDidHide(notification: NSNotification) {
        //self.tableView.setContentOffset(CGPoint(x: 0, y: self.tableView.contentSize.height - self.tableView.frame.size.height), animated: true)
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
        //let image = UIImage(named: "right_bubble")
        //let imageSize = cell.messageLabel.frame.size
        ////let maximumLabelSize = CGSize(width: self.view.bounds.width, height: 9999)
        ////let expectedLabelSize = cell.messageLabel.text.
        //UIGraphicsBeginImageContext(imageSize)
        //image!.drawInRect(CGRect(x: 0, y: 0, width: cell.messageLabel.frame.size.width + 400, height: cell.messageLabel.frame.size.height))
        //let newImage = UIGraphicsGetImageFromCurrentImageContext()
        //UIGraphicsEndImageContext()
        ////cell.messageLabel.clipsToBounds = true
        ////cell.messageLabel.backgroundColor = UIColor.redColor()
        ////cell.messageLabel.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        ////cell.messageLabel.backgroundColor = UIColor(patternImage: newImage)
        //cell.messageLabel.backgroundColor = UIColor(patternImage: image!)
        //cell!.textLabel?.text = messages[indexPath.row].text
        cell.setupData(messages[indexPath.row])
        //cell.messageLabel.backgroundColor = UIColor.redColor()
        //cell.messageLabel.text = messages[indexPath.row].text
        //cell.messageLabel.sizeToFit()
        //cell.selectionStyle = .None
        //cell.layoutIfNeeded()
        return cell
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let messageLabel = UILabel(frame: CGRect(x: 15, y: 10, width: 220, height: 9999))
        messageLabel.numberOfLines = 0
        messageLabel.lineBreakMode = .ByWordWrapping
        messageLabel.text = messages[indexPath.row].text
        messageLabel.backgroundColor = UIColor.purpleColor()
        //messageLabel.backgroundColor = UIColor.clearColor()
        messageLabel.sizeToFit()
        return max(messageLabel.frame.size.height + 10, 44)
    }
}

extension MessageViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        textView.resignFirstResponder()
    }
}
