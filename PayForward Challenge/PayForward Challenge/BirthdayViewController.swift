//
//  BirthdayViewController.swift
//  PayForward Challenge
//
//  Created by Jonathan Abercrombie on 3/4/17.
//  Copyright © 2017 Johnny Abercrombie. All rights reserved.
//

import UIKit

class BirthdayViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!

    @IBAction func submit(_ sender: Any) {
        guard datePicker.date < Date() else {
            let alert = UIAlertController(title: "Oops", message: "Invalid birthday.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        performSegue(withIdentifier: "submit", sender: nil)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "submit" {
            let dest = segue.destination as! CreateAccountTableViewController
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            dest.birthdayLabel.text = formatter.string(from: datePicker.date)
        }
    }

}
