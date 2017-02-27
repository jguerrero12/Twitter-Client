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
    var username: String?
    var profileIconURL: URL?
    
    init(dictionary: NSDictionary) {
        let user = dictionary["user"] as? NSDictionary
        
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favorites_count"] as? Int) ?? 0
        username = user?.object(forKey: "name") as? String
        let timeStampString = dictionary["created_at"] as? String
        profileIconURL = user?.object(forKey: "profile_image_url_https") as? URL
        
        if let timeStampString = timeStampString{
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timeStampString)
        }
        
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        
        
        for dictionary in dictionaries{
            let tweet = Tweet(dictionary: dictionary)
            
            tweets.append(tweet)
        }
        
        return tweets
    
    }

}
