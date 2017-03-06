//
//  Tweet.swift
//  Twitter Client
//
//  Created by Jose Guerrero on 2/21/17.
//  Copyright © 2017 Jose Guerrero. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var text: String?
    var timestamp: Date?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var user: User!
    var tweetID: String?
    var didFavorite: Bool?
    var didRetweet: Bool?
    
    
    init(dictionary: NSDictionary) {
        let user = dictionary["user"] as? NSDictionary
        self.user = User(dictionary: user!)
        
        didFavorite = dictionary["favorited"] as? Bool
        didRetweet = dictionary["retweeted"] as? Bool
        
        tweetID = dictionary["id_str"] as? String
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favorite_count"] as? Int) ?? 0
        
        let timeStampString = dictionary["created_at"] as? String
        if let timeStampString = timeStampString{
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timeStampString)
        }
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            
            tweets.append(tweet)
        }
        
        return tweets
    
    }

}
