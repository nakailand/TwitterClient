//
//  ViewController.swift
//  TwitterClient
//
//  Created by nakazy on 2015/10/24.
//  Copyright © 2015年 nakazy. All rights reserved.
//

import UIKit
import Accounts
import Social

/// 初回起動時にTwitter認証を行うクラス
class ViewController: UIViewController {
    var twitterAccount: ACAccount?
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func authenticate(sender: AnyObject) {
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (granted: Bool, error: NSError?) in
            if let error = error {
                print("error! \(error.localizedDescription)")
                return
            }
            
            if !granted {
                print("error! Twitterアカウントの利用が許可されていません")
                let alertController = UIAlertController(
                    title: "Twitterアカウントの利用が許可されていません",
                    message: "設定画面から許可をしてください",
                    preferredStyle: .Alert
                )
                alertController.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))

                dispatch_async(dispatch_get_main_queue()) {
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
                return
            }
            
            guard let accounts = accountStore.accountsWithAccountType(accountType) as? [ACAccount] where !accounts.isEmpty else {
                print("error! 設定画面からアカウントを設定してください")
                let alertController = UIAlertController(
                    title: "端末に登録されているアカウントが見つかりませんでした",
                    message: "設定画面からアカウントを設定してください",
                    preferredStyle: .Alert
                )
                alertController.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
                dispatch_async(dispatch_get_main_queue()) {
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
                return
            }
            
            self.showAccountSelectSheet(accounts)
        }
    }
    
    private func showAccountSelectSheet(accounts: [ACAccount]) {
        
        let alertController = UIAlertController(
            title: "Twitter",
            message: "アカウントを選択してください",
            preferredStyle: .ActionSheet
        )
        
        for account in accounts { alertController.addAction(
                UIAlertAction(
                    title: account.username,
                    style: .Default,
                    handler: { action in
                        self.twitterAccount = account
                        let authorizationObj = NSKeyedArchiver.archivedDataWithRootObject(account)
                        NSUserDefaults.standardUserDefaults().setObject(authorizationObj, forKey: "authorization")
                        let followrListViewController = UIStoryboard(name: "FollowerList", bundle: nil).instantiateInitialViewController() as! FollowerListViewController
                        followrListViewController.twitterAccount = account
                        self.navigationController?.pushViewController(followrListViewController, animated: true)
                    }
                )
            )
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        dispatch_async(dispatch_get_main_queue()) {
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
}
