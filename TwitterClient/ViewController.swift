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

class ViewController: UIViewController {
    var twitterAccount: ACAccount?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func authenticate(sender: AnyObject) {
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (granted: Bool, error: NSError?) in
            if error != nil {
                // エラー処理
                print("error! \(error)")
                return
            }
            
            if !granted {
                print("error! Twitterアカウントの利用が許可されていません")
                return
            }
            
            let accounts = accountStore.accountsWithAccountType(accountType) as! [ACAccount]
            if accounts.count == 0 {
                print("error! 設定画面からアカウントを設定してください")
                return
            }
            self.showAccountSelectSheet(accounts)
        }
    }
    
    // アカウント選択のActionSheetを表示する
    private func showAccountSelectSheet(accounts: [ACAccount]) {
        
        let alertController = UIAlertController(
            title: "Twitter",
            message: "アカウントを選択してください",
            preferredStyle: .ActionSheet
        )
        
        // アカウント選択のActionSheetを表示するボタン
        for account in accounts {alertController.addAction(
                UIAlertAction(
                    title: account.username,
                    style: .Default,
                    handler: { action in
                        self.twitterAccount = account
                        let authorizationObj = NSKeyedArchiver.archivedDataWithRootObject(account)
                        NSUserDefaults.standardUserDefaults().setObject(authorizationObj, forKey: "authorization")
                        let followrListViewController = UIStoryboard(name: "FollowerList", bundle: nil).instantiateInitialViewController() as! TwitterListViewController
                        followrListViewController.twitterAccount = account
                        self.navigationController?.pushViewController(followrListViewController, animated: true)
                    }
                )
            )
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
}

