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

/// Followerのリストを表示するクラス
final class FollowerListViewController: UIViewController {
    
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
        if let account = twitterAccount {
            getFollowers(account)
        }
        
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func getFollowers(account: ACAccount) {
        let URL = NSURL(string: followersListURL)
        
        let request = SLRequest(
            forServiceType: SLServiceTypeTwitter,
            requestMethod: .GET,
            URL: URL,
            parameters: nil
        )
        
        request.account = account
        request.performRequestWithHandler { (responseData, urlResponse, error) in
            if let error = error {
                print("error is \(error.localizedDescription)")
                return
            }
            do {
                let result = try NSJSONSerialization.JSONObjectWithData(responseData, options: .AllowFragments) as! NSDictionary
                guard let users = result["users"] as? NSArray else {
                    print("json users error")
                    return
                }
                dispatch_async(dispatch_get_main_queue()) {
                    users.forEach {
                        guard let screenName = $0["screen_name"] as? String , let iconUrl = $0["profile_image_url"] as? String else {
                            return
                        }
                        self.followers.append(Follower(name: screenName, iconUrl: iconUrl))
                    }
                }
            } catch let error as NSError {
                print("json error: \(error.localizedDescription)")
            }
        }
    }
}

extension FollowerListViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let messageViewController = MessageViewController()
        messageViewController.title = followers[indexPath.row].name
        self.navigationController?.pushViewController(messageViewController, animated: true)
    }
}

extension FollowerListViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followers.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("FollowerTableViewCell") as? FollowerListTableViewCell else {
            return UITableViewCell()
        }
        
        guard let url = NSURL(string: followers[indexPath.row].iconUrl) else {
            return UITableViewCell()
        }
        
        /// 非同期で画像読み込み
        let req = NSURLRequest(URL: url, cachePolicy: .UseProtocolCachePolicy, timeoutInterval: 10)
        NSURLConnection.sendAsynchronousRequest(req, queue: NSOperationQueue.mainQueue()) { (res, data, error) in
            if let error = error {
                print("error! \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                return
            }
            
            cell.icon.image = UIImage(data: data)
        }
        
        cell.nameLabel.text = "@\(self.followers[indexPath.row].name)"
        
        return cell
    }
}
