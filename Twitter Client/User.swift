//
//  User.swift
//  Twitter Client
//
//  Created by Jose Guerrero on 2/21/17.
//  Copyright © 2017 Jose Guerrero. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var name: String?
    var screenName: String?
    var profileURL: URL?
    var tagline: String?
    var dictionary: NSDictionary
    
    init(dictionary: NSDictionary) {
        
        self.dictionary = dictionary as NSDictionary
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        let chkProfileURL = dictionary["profile_image_url_https"] as? String
        if chkProfileURL != nil {
            profileURL = URL(string: chkProfileURL!)
        }
        
        tagline = dictionary["description"] as? String
        
    }
    
    static var _currentUser: User?
    
    class var currentUser: User? {
        get {
            
            if _currentUser == nil {
                let defaults = UserDefaults.standard
                let userData = defaults.object(forKey: "currentUser") as? Data
                
                if let userData = userData {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            
            return _currentUser
        }
        set(user) {
            
            _currentUser = user
            let defaults = UserDefaults.standard
            
            if let user = user{
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary, options: [])
                defaults.set(data, forKey: "currentUser")
            }
            else{
               defaults.removeObject(forKey: "currentUser")
            }
            
            
            defaults.synchronize()
        }
    }
    
    
    
}
