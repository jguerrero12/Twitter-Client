//
//  ReplyViewController.swift
//  Twitter Client
//
//  Created by Jose Guerrero on 3/4/17.
//  Copyright © 2017 Jose Guerrero. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {

    // UI Elements
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tweetTxt: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var textField: UITextView!
    
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetTxt.text = tweet.text
        timeLabel.text = "\(DateFormatter.localizedString(from: tweet.timestamp!, dateStyle: .short, timeStyle: .none))"
        usernameLabel.text = tweet.username
        screennameLabel.text = "@\(tweet.screenname!)"
        
        textField.text = screennameLabel.text
        if let url = tweet.profileIconURL {
            profileImage.setImageWith(url)
        }
        else{
            profileImage.image = UIImage(named: "TwitterLogoBlue")
        }
    }

    @IBAction func onCancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func onTweet(_ sender: Any) {
        TwitterClient.sharedInstance?.tweet(tweetTxt: textField.text, inReplyTo: tweet.tweetID! , success: { (tweet: Tweet) in
            self.tweet = tweet
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
        self.dismiss(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
