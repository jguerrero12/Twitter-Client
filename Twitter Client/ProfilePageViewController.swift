//
//  ProfilePageViewController.swift
//  Twitter Client
//
//  Created by Jose Guerrero on 3/4/17.
//  Copyright © 2017 Jose Guerrero. All rights reserved.
//

import UIKit

class ProfilePageViewController: UIViewController {

    // UI Elements
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileBackground: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var tweetCount: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var followersCount: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // store info about user
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = user.name
        screennameLabel.text = "@\((user.screenName)!)"
        tweetCount.text = "\((user.tweetCount)!)"
        followingCount.text = "\((user.followingCount)!)"
        followersCount.text = "\((user.followerCount)!)"
        if let url = user.profileURL {
            profileImage.setImageWith(url)
        }
        else{
            profileImage.image = UIImage(named: "TwitterLogoBlue")
        }
        if let url = user.profileBackgroundURL {
            profileBackground.setImageWith(url)
        }
        
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
