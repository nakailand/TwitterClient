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
        if let account = twitterAccount {
            getFollowers(account)
        }
        
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // followerを取得
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

extension TwitterListViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let messageViewController = MessageViewController()
        messageViewController.title = followers[indexPath.row].name
        self.navigationController?.pushViewController(messageViewController, animated: true)
    }
}

extension TwitterListViewController: UITableViewDataSource {
    
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
        
        do {
            let data =  try NSData(contentsOfURL: url, options: NSDataReadingOptions.DataReadingMappedIfSafe)
            cell.icon.image = UIImage(data: data)
            cell.nameLabel.text = "@\(followers[indexPath.row].name)"
            return cell
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return UITableViewCell()
    }
}
