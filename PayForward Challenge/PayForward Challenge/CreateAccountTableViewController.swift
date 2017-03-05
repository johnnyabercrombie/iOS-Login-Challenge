//
//  CreateAccountTableViewController.swift
//  PayForward Challenge
//
//  Created by Jonathan Abercrombie on 3/2/17.
//  Copyright © 2017 Johnny Abercrombie. All rights reserved.
//

import UIKit

class CreateAccountTableViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var zipCodeField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    @IBAction func backFromBirthday(segue: UIStoryboardSegue) {}
    
    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapper = UITapGestureRecognizer(target: self, action: #selector(CreateAccountTableViewController.handleSingleTap(_:)))
        self.view.addGestureRecognizer(tapper)

        firstNameField.delegate = self
        lastNameField.delegate = self
        emailField.delegate = self
        zipCodeField.delegate = self
        usernameField.delegate = self
        passwordField.delegate = self
    }
    
    @IBAction func submit(_ sender: Any) {
        // names must contain only letters and begin with a capital letter and be between 2-20 characters
        let nameRegEx = "[A-Z][a-zA-Z]{2,20}"
        let nameTest = NSPredicate(format: "SELF MATCHES %@", nameRegEx)
        guard let firstName = firstNameField.text,
            nameTest.evaluate(with: firstName) else {
            let alert = UIAlertController(title: "Oops", message: "First name not valid.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }

        guard let lastName = lastNameField.text,
            nameTest.evaluate(with: lastName) else {
            let alert = UIAlertController(title: "Oops", message: "Last name not valid.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }

        let emailRegEx = "^[_A-Za-z0-9-+]+(\\.[_A-Za-z0-9-+]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z‌​]{2,40})$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        guard let email = emailField.text, emailTest.evaluate(with: email) else {
            let alert = UIAlertController(title: "Oops", message: "Email not valid.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }

        guard let birthday = birthdayLabel.text, birthday.characters.count >= 10, birthday.characters.count < 20 else {
            let alert = UIAlertController(title: "Oops", message: "Birthday field required.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        // match 5 or 9 digit zip codes
        let zipCodeRegEx = "^[0-9]{5}(?:-[0-9]{4})?$"
        let zipCodeTest = NSPredicate(format: "SELF MATCHES %@", zipCodeRegEx)
        guard let zipCode = zipCodeField.text, zipCodeTest.evaluate(with: zipCode) else {
            let alert = UIAlertController(title: "Oops", message: "Zip code not valid.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        // usernames must only contain letters and digits and be between 2-10 characters
        let usernameRegEx = "^[a-zA-Z0-9]{2,10}"
        let usernameTest = NSPredicate(format: "SELF MATCHES %@", usernameRegEx)
        guard let username = usernameField.text, usernameTest.evaluate(with: username) else {
            let alert = UIAlertController(title: "Oops", message: "Usernames must contain only letters and digits, and must be between 2 and 10 characters long.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }

        // passwords must contain 1 digit, 1 lower case letter, 1 upper case letter, and be between 8-20 characters
        let passwordRegEx = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{8,20}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        guard let password = passwordField.text, passwordTest.evaluate(with: password) else {
            let alert = UIAlertController(title: "Oops", message: "Passwords must have at least one lower case letter, one upper case letter, one digit, and be between 8 and 20 characters long.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }

        user.firstName = firstName
        user.lastName = lastName
        user.email = email
        user.birthday = birthday
        user.zipCode = zipCode
        user.username = username
        user.password = password
        
        performSegue(withIdentifier: "toPhoneNumber", sender: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func handleSingleTap(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPhoneNumber" {
            let dest = segue.destination as! PhoneNumberViewController
            dest.user = user
        }
    }

}
