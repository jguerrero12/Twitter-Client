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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        update()
    }
    
    // When user presses favorite...
    @IBAction func onFavorite(_ sender: Any) {
        
    }
    
    // When user presses retweet...
    @IBAction func onRetweet(_ sender: Any) {
        
    }
    
    // when user presses reply...
    @IBAction func onReply(_ sender: Any) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // update UI Elements with current data
    func update(){
        tweetTxt.text = tweet.text
        timeLabel.text = "\(DateFormatter.localizedString(from: tweet.timestamp!, dateStyle: .short, timeStyle: .short))"
        usernameLabel.text = tweet.username
        screennameLabel.text = "@\(tweet.screenname!)"
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
        
        if let url = tweet.profileIconURL {
            profileImage.setImageWith(url)
        }
        else{
            profileImage.image = UIImage(named: "TwitterLogoBlue")
        }
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
