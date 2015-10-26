//
//  FollowerListViewController.swift
//  TwitterClient
//
//  Created by nakazy on 2015/10/24.
//  Copyright © 2015年 nakazy. All rights reserved.
//

import UIKit
import Accounts
import Social

class TwitterListViewController :UIViewController {
    
    var twitterAccount: ACAccount?
    @IBOutlet weak var tableView: UITableView!
    private var followers: [String] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        NSUserDefaults.standardUserDefaults().removeObjectForKey("authorization")
        if let obj = NSUserDefaults.standardUserDefaults().objectForKey("authorization") {
            let account = NSKeyedUnarchiver.unarchiveObjectWithData(obj as! NSData)
            getTimeline(account as! ACAccount)
        } else {
            let accountStore = ACAccountStore()
            let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
            accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (granted:Bool, error:NSError?) -> Void in
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
                
                // 取得したアカウントで処理を行う...
                
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // アカウント選択のActionSheetを表示する
    private func showAccountSelectSheet(accounts: [ACAccount]) {
        
        let alert = UIAlertController(title: "Twitter",
            message: "アカウントを選択してください",
            preferredStyle: .ActionSheet)
        
        // アカウント選択のActionSheetを表示するボタン
        for account in accounts {
            alert.addAction(UIAlertAction(title: account.username,
                style: .Default,
                handler: { (action) -> Void in
                    //
                    print("your select account is \(account)")
                    self.twitterAccount = account
                    let obj = NSKeyedArchiver.archivedDataWithRootObject(account)
                    NSUserDefaults.standardUserDefaults().setObject(obj, forKey: "authorization")
                    self.getTimeline(self.twitterAccount!)
            }))
        }
        
        // キャンセルボタン
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        // 表示する
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    // タイムラインを取得する
    private func getTimeline(account: ACAccount) {
        let URL = NSURL(string: "https://api.twitter.com/1.1/followers/list.json")
        
        // GET/POSTやパラメータに気をつけてリクエスト情報を生成
        let request = SLRequest(forServiceType: SLServiceTypeTwitter,
            requestMethod: .GET,
            URL: URL,
            parameters: nil)
        
        // 認証したアカウントをセット
        request.account = account
        
        // APIコールを実行
        request.performRequestWithHandler { (responseData, urlResponse, error) -> Void in
            
            if error != nil {
                print("error is \(error)")
            }
            else {
                // 結果の表示
                let result = try? NSJSONSerialization.JSONObjectWithData(responseData, options: .AllowFragments)
                if let array = result as? NSDictionary {
                    for element in array.enumerate() {
                        print("________")
                        if element.index == 1 {
                            let arr = element.element.value as! NSArray
                            for ele in arr.enumerate() {
                                dispatch_async(dispatch_get_main_queue(), {
                                    self.followers.append(ele.element["screen_name"] as! String)
                                    print(ele.element["profile_image_url"] as! String)
                                })
                            }
                        }
                    }
                }
            }
        }
    }
}

extension TwitterListViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let messageViewController = UIStoryboard(name: "MessageViewController", bundle: nil).instantiateInitialViewController() as! MessageViewController
        self.navigationController?.pushViewController(messageViewController, animated: true)
    }
}

extension TwitterListViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followers.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FollowerTableViewCell") as! FollowerListTableViewCell
        cell.icon.image = try! UIImage(data: NSData(contentsOfURL: NSURL(string: "https://pbs.twimg.com/profile_images/589847230439239680/TCd0xz7Q_400x400.jpg")!, options: NSDataReadingOptions.DataReadingMappedIfSafe))
        print(cell.icon.image!)
        cell.nameLabel.text = "aaaa"
        
        return cell
    }
}