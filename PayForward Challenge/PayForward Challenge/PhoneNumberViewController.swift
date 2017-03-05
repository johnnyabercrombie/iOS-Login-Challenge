//
//  PhoneNumberViewController.swift
//  PayForward Challenge
//
//  Created by Jonathan Abercrombie on 3/2/17.
//  Copyright © 2017 Johnny Abercrombie. All rights reserved.
//

import UIKit

class PhoneNumberViewController: UIViewController {

    @IBOutlet weak var tosLabel: UILabel!
    @IBOutlet weak var phoneNumberField: UITextField!
    
    var user: User? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapper = UITapGestureRecognizer(target: self, action: #selector(PhoneNumberViewController.handleSingleTap(_:)))
        self.view.addGestureRecognizer(tapper)

        let range = NSMakeRange(32, 46)
        let attributedText = NSMutableAttributedString(string: tosLabel.text!)
        attributedText.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.styleSingle.rawValue, range: range)
        tosLabel.attributedText = attributedText
    }
    
    @IBAction func submit(_ sender: Any) {
        let phoneNumberRegEx = "^[0-9]{10}"
        let phoneNumberTest = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegEx)
        guard let phoneNumber = phoneNumberField.text, phoneNumberTest.evaluate(with: phoneNumber) else {
            let alert = UIAlertController(title: "Oops", message: "Phone numbers must contain exactly 10 digits.", preferredStyle: UIAlertControllerStyle.actionSheet)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        user?.phoneNumber = Int(phoneNumber)
        
        performSegue(withIdentifier: "toHome", sender: nil)
    }

    func handleSingleTap(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toHome" {
            let dest = segue.destination as! HomeViewController
            dest.user = user
        }
    }

}
