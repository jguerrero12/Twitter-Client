//
//  TweetCell.swift
//  Twitter Client
//
//  Created by Jose Guerrero on 2/26/17.
//  Copyright © 2017 Jose Guerrero. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    weak var delegate: TableViewCellDelegate?
    @IBOutlet weak var profileImage: UIImageView!
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
            timeAgoLabel.text = "\(tweet.timestamp!)"
            usernameLabel.text = tweet.username
            sndUsernameLabel.text = "@\(tweet.username!)"
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
            
            if let url = tweet.profileIconURL {
                profileImage.setImageWith(url)
            }
            else{
                profileImage.image = UIImage(named: "TwitterLogoBlue")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
}
