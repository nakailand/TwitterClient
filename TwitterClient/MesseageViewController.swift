//
//  MesseageViewController.swift
//  TwitterClient
//
//  Created by nakazy on 2015/10/25.
//  Copyright © 2015年 nakazy. All rights reserved.
//

import UIKit

class MessageViewController :UIViewController {
    @IBOutlet weak var commentView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        self.view.backgroundColor = UIColor.redColor()
        let tap = UITapGestureRecognizer(target: self, action: "tap")
        self.view.addGestureRecognizer(tap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            print(userInfo)
            let keyboardRect = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue()
            if let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSTimeInterval {
                UIView.animateWithDuration(duration, animations: {
                    //self.commentView.frame.origin.y = keyboardRect!.origin.y - self.commentView.frame.size.height
                    self.commentView.transform = CGAffineTransformMakeTranslation(0, -(self.view.bounds.height - keyboardRect!.origin.y))
                    //self.commentView.transform = CGAffineTransformMakeTranslation(0, -100)
                })
            }
            //self.scrollView.setContentOffset(CGPoint(x: 0, y: self.scrollView.contentSize.height - self.scrollView.frame.size.height), animated: true)
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
            //self.scrollView.setContentOffset(CGPoint(x: 0, y: self.scrollView.contentSize.height - self.scrollView.frame.size.height), animated: true)
        }
    }
    
    func tap() {
        self.textView.resignFirstResponder()
    }
}