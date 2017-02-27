//
//  TwitterClient.swift
//  Twitter Client
//
//  Created by Jose Guerrero on 2/26/17.
//  Copyright © 2017 Jose Guerrero. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static let sharedInstance = TwitterClient(baseURL: URL(string: "https://api.twitter.com")!, consumerKey: "MgFbMZnrXrBxLNX8AdU2IaozK", consumerSecret: "P39WLP5wxeTx4NJaPnlGY13xGkbvqw8T34cQeupGSpTNsDtWCd")
    
    var loginSuccess: (() -> ())?
    var loginfailure: ((Error)->())?
    
    func login(success: @escaping () -> (), failure: @escaping (Error) -> ()){
        
        loginSuccess = success
        loginfailure = failure
        
        TwitterClient.sharedInstance?.deauthorize()
        TwitterClient.sharedInstance?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "twitter-client://oauth"), scope: nil, success: {
            (requestToken: BDBOAuth1Credential?) -> Void in
            
            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)")!
            
            UIApplication.shared.open(url)
            
        }, failure: {
            (error: Error?) -> Void in
            print("error: \(error?.localizedDescription)")
            self.loginfailure?(error!)
        })
    }
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UserDidLogout"), object: nil)
    }
    
    func handleOpenURL(url: URL) {
        
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: {(accessToken: BDBOAuth1Credential?) in
            print("I got the access token")
            
            self.currentAccount(success: { (user: User) in
                User.currentUser = user
                self.loginSuccess?()
            }, failure: { (error: Error) in
                self.loginfailure?(error)
            })
            
            
            
        }, failure: {
            (error: Error?) -> Void in
            print("Error: \(error?.localizedDescription)")
            self.loginfailure?(error!)
        })
        
        
    }
    
    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()){
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success:{ (task: URLSessionDataTask, response: Any?) in
            
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            success(tweets)
            
            
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        })
    }
    
    func currentAccount(success: @escaping (User)->(), failure: @escaping (Error)->()){
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            print("user: \(response!)")
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            
            success(user)
            print("username = \(user.name!)")
            
            
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error)
            print("error: \(error.localizedDescription)")
        })
    }
    
    
    
}
