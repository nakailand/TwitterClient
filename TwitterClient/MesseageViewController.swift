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
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        self.view.backgroundColor = UIColor.redColor()
        let tap = UITapGestureRecognizer(target: self, action: "tap")
        self.view.addGestureRecognizer(tap)
        tableView.separatorColor = UIColor.clearColor()
        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableViewAutomaticDimension
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
                    self.tableView.setContentOffset(CGPoint(x: 0, y: self.tableView.contentSize.height - self.tableView.frame.size.height), animated: true)
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
        self.textView.resignFirstResponder()
    }
    
    @IBAction func postMessage(sender: AnyObject) {
        messages.append(Message(text: textView.text))
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
        cell.messageLabel.backgroundColor = UIColor.redColor()
        cell.messageLabel.text = messages[indexPath.row].text
        cell.messageLabel.sizeToFit()
        cell.selectionStyle = .None
        cell.layoutIfNeeded()
        return cell
    }
}

extension MessageViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        textView.resignFirstResponder()
    }
}
