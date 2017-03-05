//
//  HomeViewController.swift
//  PayForward Challenge
//
//  Created by Jonathan Abercrombie on 3/3/17.
//  Copyright © 2017 Johnny Abercrombie. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var rightBarButton: UIBarButtonItem!
    var user: User? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        rightBarButton.title = user?.username
    }
    
    @IBAction func rightBarButtonClicked(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Logout", message: "Do you wish to logout?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { [weak self] _ in
            self?.performSegue(withIdentifier: "logout", sender: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
