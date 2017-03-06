//
//  TweetDetailViewController.swift
//  Twitter Client
//
//  Created by Jose Guerrero on 3/3/17.
//  Copyright © 2017 Jose Guerrero. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {

    // UI Elements
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var tweetTxt: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    // Tweet Model
    var tweet: Tweet!
    
    // Calling cell's indexpath
    var indexPath: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        update()
    }
    
    // When user presses favorite...
    @IBAction func onFavorite(_ sender: Any) {
        if tweet.didFavorite == false {
            TwitterClient.sharedInstance?.favorite(tweetID: tweet.tweetID!, success: { (tweet: Tweet) in
                self.tweet = tweet
                self.update()
            }, failure: { (error: Error) in
                print(error.localizedDescription)
            })
        }
        else{
            TwitterClient.sharedInstance?.unfavorite(tweetID: tweet.tweetID!, success: { (tweet: Tweet) in
                self.tweet = tweet
                self.update()
            }, failure: { (error: Error) in
                print(error.localizedDescription)
            })
        }
    }
    
    // When user presses retweet...
    @IBAction func onRetweet(_ sender: Any) {
        if tweet.didRetweet == false {
            TwitterClient.sharedInstance?.retweet(tweetID: tweet.tweetID!, success: { (tweet: Tweet) in
                self.tweet = tweet
                self.update()
            }, failure: { (error: Error) in
                print(error.localizedDescription)
            })
        }
        else{
            TwitterClient.sharedInstance?.unretweet(tweetID: tweet.tweetID!, success: { (tweet: Tweet) in
                self.tweet = tweet
                self.update()
                
            }, failure: { (error: Error) in
                print(error.localizedDescription)
            })
        }
    }
    
    // when user presses reply...
    @IBAction func onReply(_ sender: Any) {
        performSegue(withIdentifier: "postReplySegue", sender: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // update UI Elements with current data
    func update(){
        tweetTxt.text = tweet.text
        timeLabel.text = "\(DateFormatter.localizedString(from: tweet.timestamp!, dateStyle: .short, timeStyle: .short))"
        usernameLabel.text = tweet.user.name
        screennameLabel.text = "@\((tweet.user.screenName)!)"
        if tweet.didFavorite! {
            favoriteButton.setImage(UIImage(named: "favor-icon-red"), for: .normal)
        }
        else{
            favoriteButton.setImage(UIImage(named: "favor-icon"), for: .normal)
        }
        if tweet.didRetweet!{
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
        }
        else{
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: .normal)
        }
        
        favoriteCountLabel.text = "\(tweet.favoritesCount)"
        retweetCountLabel.text = "\(tweet.retweetCount)"
        
        if let url = tweet.user?.profileURL {
            profileImage.setImageWith(url)
        }
        else{
            profileImage.image = UIImage(named: "TwitterLogoBlue")
        }
    }
    
    // this runs when runnning unwind segue, Need fix!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let NC = segue.destination as? UINavigationController{
        let replyVC = NC.topViewController as! TweetViewController
        replyVC.tweet = tweet
        }
        
    }

}
