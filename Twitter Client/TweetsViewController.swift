//
//  TweetsViewController.swift
//  Twitter Client
//
//  Created by Jose Guerrero on 2/26/17.
//  Copyright © 2017 Jose Guerrero. All rights reserved.
//

import UIKit
import AFNetworking

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TableViewCellDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var tweets: [Tweet]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 87
        tableView.rowHeight = UITableViewAutomaticDimension
        
        TwitterClient.sharedInstance?.homeTimeline(success: {(tweets: [Tweet]) in
            self.tweets = tweets
            
            for tweet in tweets{
                print(tweet.text!)
            }
            self.tableView.reloadData()
        }, failure: {(error:Error) in
            print(error.localizedDescription)
        })
        
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets.count
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as? TweetCell
        
        let tweet = tweets[indexPath.row]
        cell?.tweet = tweet
        cell?.indexPath = indexPath
        cell?.delegate = self
        
        return cell!
        
    }
    
    func onRetweet(for cell:TweetCell) {
        if cell.tweet.didRetweet == false {
            TwitterClient.sharedInstance?.retweet(tweetID: cell.tweet.tweetID!, success: { (tweet: Tweet) in
                self.tweets[(cell.indexPath?.row)!] = tweet
                self.tableView.reloadRows(at: [cell.indexPath!], with: .none)
            }, failure: { (error: Error) in
                print(error.localizedDescription)
            })
        }
        else{
            TwitterClient.sharedInstance?.unretweet(tweetID: cell.tweet.tweetID!, success: { (tweet: Tweet) in
                self.tweets[(cell.indexPath?.row)!] = tweet
                self.tableView.reloadRows(at: [cell.indexPath!], with: .none)
                
            }, failure: { (error: Error) in
                print(error.localizedDescription)
            })
        }
    }
    
    func onFavorite(for cell:TweetCell) {
        if cell.tweet.didFavorite == false {
            TwitterClient.sharedInstance?.favorite(tweetID: cell.tweet.tweetID!, success: { (tweet: Tweet) in
                self.tweets[(cell.indexPath?.row)!] = tweet
                self.tableView.reloadRows(at: [cell.indexPath!], with: .none)
            }, failure: { (error: Error) in
                print(error.localizedDescription)
            })
        }
        else{
            TwitterClient.sharedInstance?.unfavorite(tweetID: cell.tweet.tweetID!, success: { (tweet: Tweet) in
                self.tweets[(cell.indexPath?.row)!] = tweet
                self.tableView.reloadRows(at: [cell.indexPath!], with: .none)
            }, failure: { (error: Error) in
                print(error.localizedDescription)
            })
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onLogoutButton(_ sender: Any) {
        TwitterClient.sharedInstance?.logout()
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
