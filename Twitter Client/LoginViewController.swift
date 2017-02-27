//
//  LoginViewController.swift
//  Twitter Client
//
//  Created by Jose Guerrero on 2/20/17.
//  Copyright © 2017 Jose Guerrero. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLoginButton(_ sender: Any) {
        TwitterClient.sharedInstance?.login(success: {
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
        },
        failure: {(error: Error) in
            print("Error: \(error.localizedDescription)")
        })
    }
    
    

}

