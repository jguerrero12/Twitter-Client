//
//  ReplyViewController.swift
//  Twitter Client
//
//  Created by Jose Guerrero on 3/4/17.
//  Copyright © 2017 Jose Guerrero. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate {
    
    // UI Elements
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tweetTxt: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var textField: UITextView!
    
    var tweet: Tweet!
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        
        if tweet != nil {
            tweetTxt.text = tweet.text
            timeLabel.text = "\(DateFormatter.localizedString(from: tweet.timestamp!, dateStyle: .short, timeStyle: .none))"
            usernameLabel.text = tweet.user.name
            screennameLabel.text = "@\((tweet.user.screenName)!)"
            
            textField.text = screennameLabel.text
            if let url = tweet.user.profileURL {
                profileImage.setImageWith(url)
            }
            else{
                profileImage.image = UIImage(named: "TwitterLogoBlue")
            }
        }
        else {
            timeLabel.text = "now"
            usernameLabel.text = user.name
            tweetTxt.text = ""
            screennameLabel.text = "@\((user.screenName)!)"
            textField.text = "What is happening?"
            textField.textColor = UIColor.lightGray
            if let url = user.profileURL {
                profileImage.setImageWith(url)
            }
            else{
                profileImage.image = UIImage(named: "TwitterLogoBlue")
            }
        }
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "What is happening?"
            textView.textColor = UIColor.lightGray
        }
    }
    
    @IBAction func onCancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func onTweet(_ sender: Any) {
        if tweet != nil {
            TwitterClient.sharedInstance?.tweet(tweetTxt: textField.text, inReplyTo: tweet.tweetID!, success: { (tweet: Tweet) in
                self.tweet = tweet
            }, failure: { (error: Error) in
                print(error.localizedDescription)
            })
        }
        else{
            TwitterClient.sharedInstance?.tweet(tweetTxt: textField.text, success: { (tweet: Tweet) in
                self.tweet = tweet
            }, failure: { (error: Error) in
                print(error.localizedDescription)
            })
        }
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
