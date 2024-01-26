//
//  ViewController.swift
//  PhotoSharing
//
//  Created by Güray Gül on 26.01.2024.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signUpButtonTapped(_ sender: Any) {
        
        if emailTextField.text != "" && passwordTextField.text != "" {
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { authDataResult, error in
                if error != nil {
                    self.throwAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "An error occured. Please try again later!")
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        } else {
            throwAlert(titleInput: "Alert!", messageInput: "Please fill email & password fields!")
        }
    }
    @IBAction func signInButtonTapped(_ sender: Any) {
        
        if emailTextField.text != "" && passwordTextField.text != "" {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { authDataResult, error in
                if error != nil {
                    self.throwAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "An error occured. Please try again later!")
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        } else {
            throwAlert(titleInput: "Alert!", messageInput: "Please fill email & password fields!")
        }
        
    }
    
    func throwAlert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}

