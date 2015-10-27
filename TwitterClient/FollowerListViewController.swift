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

class TwitterListViewController: UIViewController {
    
    var twitterAccount: ACAccount?
    let followersListURL = "https://api.twitter.com/1.1/followers/list.json"
    @IBOutlet weak var tableView: UITableView!
    private var followers: [Follower] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSUserDefaults.standardUserDefaults().removeObjectForKey("authorization")
        if let obj = NSUserDefaults.standardUserDefaults().objectForKey("authorization") {
            let account = NSKeyedUnarchiver.unarchiveObjectWithData(obj as! NSData)
            getFollowers(account as! ACAccount)
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
                        let obj = NSKeyedArchiver.archivedDataWithRootObject(account)
                        NSUserDefaults.standardUserDefaults().setObject(obj, forKey: "authorization")
                        self.getFollowers(self.twitterAccount!)
                    }
                )
            )
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // followerを取得
    private func getFollowers(account: ACAccount) {
        let URL = NSURL(string: followersListURL)
        
        let request = SLRequest(forServiceType: SLServiceTypeTwitter,
            requestMethod: .GET,
            URL: URL,
            parameters: nil)
        
        request.account = account
        
        request.performRequestWithHandler { (responseData, urlResponse, error) -> Void in
            
            if let error = error {
                print("error is \(error)")
            } else {
                let result = try? NSJSONSerialization.JSONObjectWithData(responseData, options: .AllowFragments)
                if let array = result as? NSDictionary {
                    for element in array.enumerate() {
                        if element.index == 1 {
                            let arr = element.element.value as! NSArray
                            for ele in arr.enumerate() {
                                dispatch_async(dispatch_get_main_queue(), {
                                    self.followers.append(Follower(
                                        name: ele.element["screen_name"] as! String,
                                        iconUrl: ele.element["profile_image_url"] as! String
                                        )
                                    )
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
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let messageViewController = UIStoryboard(name: "MessageViewController", bundle: nil).instantiateInitialViewController() as! MessageViewController
        messageViewController.title = followers[indexPath.row].name
        self.navigationController?.pushViewController(messageViewController, animated: true)
    }
}

extension TwitterListViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followers.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FollowerTableViewCell") as! FollowerListTableViewCell
        let url = NSURL(string: followers[indexPath.row].iconUrl)
        do {
            let data =  try NSData(contentsOfURL: url!, options: NSDataReadingOptions.DataReadingMappedIfSafe)
            let image = UIImage(data: data)
            cell.icon.image = image
            cell.nameLabel.text = "@\(followers[indexPath.row].name)"
            
            return cell
        } catch {
        }
        return UITableViewCell()
    }
}