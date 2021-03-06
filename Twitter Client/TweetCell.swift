//
//  TweetCell.swift
//  Twitter Client
//
//  Created by Jose Guerrero on 2/26/17.
//  Copyright © 2017 Jose Guerrero. All rights reserved.
//

import UIKit
import AFNetworking

class TweetCell: UITableViewCell {

    weak var delegate: TableViewCellDelegate?
    
    @IBOutlet weak var profileImage: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var timeAgoLabel: UILabel!
    @IBOutlet weak var sndUsernameLabel: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favoritesCount: UILabel!
    @IBOutlet weak var favoriteIcon: UIButton!
    @IBOutlet weak var retweetIcon: UIButton!
    
    var indexPath: IndexPath?
    var tweet: Tweet!{
        didSet{
            tweetTextLabel.text = tweet.text
            timeAgoLabel.text = "\(DateFormatter.localizedString(from: tweet.timestamp!, dateStyle: .short, timeStyle: .none))"
            usernameLabel.text = tweet.user?.name
            sndUsernameLabel.text = "@\((tweet.user.screenName)!)"
            if tweet.didFavorite! {
                favoriteIcon.setImage(UIImage(named: "favor-icon-red"), for: .normal)
            }
            else{
                favoriteIcon.setImage(UIImage(named: "favor-icon"), for: .normal)
            }
            if tweet.didRetweet!{
                retweetIcon.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
            }
            else{
                retweetIcon.setImage(UIImage(named: "retweet-icon"), for: .normal)
            }
            
            favoritesCount.text = "\(tweet.favoritesCount)"
            retweetCount.text = "\(tweet.retweetCount)"
            
            if let url = tweet.user?.profileURL {
                profileImage.setBackgroundImageFor(
                    .normal, with: url)
            }
            else{
                profileImage.imageView?.image = UIImage(named: "TwitterLogoBlue")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func onTapProfile(_ sender: Any) {
        delegate?.onTapProfile(for: self)
    }
    
    @IBAction func onRetweet(_ sender: Any) {
        delegate?.onRetweet(for: self)
    }
    
    @IBAction func onFavoriting(_ sender: Any) {
        delegate?.onFavorite(for: self)
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

protocol TableViewCellDelegate: class {
    func onRetweet(for cell:TweetCell)
    func onFavorite(for cell:TweetCell)
    func onTapProfile(for cell:TweetCell)
    //func onReply(for cell:TweetCell)
    
}
