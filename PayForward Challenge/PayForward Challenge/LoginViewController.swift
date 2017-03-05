//
//  FirstViewController.swift
//  PayForward Challenge
//
//  Created by Jonathan Abercrombie on 2/28/17.
//  Copyright © 2017 Johnny Abercrombie. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBAction func logout(segue: UIStoryboardSegue) {}

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
}
