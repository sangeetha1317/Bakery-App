//
//  ViewController.swift
//  lab2
//
//  Created by Sangeetha Thyagarajan on 2024-05-24.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {
    private let segueWelcome = "goToWelcome"
    let emailReg = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"

    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var emailErrorText: UILabel!
    
    @IBOutlet weak var passwordErrorText: UILabel!
    
    @IBOutlet weak var loginbtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.delegate = self
        passwordField.delegate = self
        
        configureInitialLoginValues()
    }
    
    private func configureInitialLoginValues() {
        emailErrorText.isHidden = true
        passwordErrorText.isHidden = true
        loginbtn.isEnabled = false
    }

    @IBAction func onEmailTextChanged(_ sender: UITextField) {
        let email = emailField.text ?? ""
        
        emailErrorText.text = isEmailValid(email)
    }
    
    func isEmailValid(_ email:String) -> String {
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailReg)
        let password = passwordField.text ?? ""

        if(email.isEmpty){
            emailErrorText.isHidden = false
            loginbtn.isEnabled = false
            return "Email address is required"
        }else if(!emailPredicate.evaluate(with: email)){
            emailErrorText.isHidden = false
            loginbtn.isEnabled = false
            return "Please enter a valid email"
        }else if(!email.isEmpty){
            emailErrorText.isHidden = true
            loginbtn.isEnabled = !password.isEmpty
            return ""
        }else{
            return ""
        }
    }
    
    @IBAction func onPasswordTextChanged(_ sender: UITextField) {
        let email = emailField.text ?? ""
        let password = passwordField.text ?? ""

        passwordErrorText.isHidden = !password.isEmpty
        loginbtn.isEnabled = emailErrorText.isHidden && !email.isEmpty && !password.isEmpty
    }
    
    @IBAction func loginsubmit(_ sender: UIButton) {
        let email = emailField.text ?? ""
        let password = passwordField.text ?? ""
        
            Auth.auth().signIn(withEmail: email, password: password) {
                [weak self] authResult, error in
                guard let strongSelf = self else {
                    return
                }
                if error != nil {
                    strongSelf.showAlert(title:"Authentication Error", message: "Invalid email or password")
                    strongSelf.passwordField.text = ""
                    strongSelf.passwordErrorText.isHidden = false
                    strongSelf.loginbtn.isEnabled = false
                }
                strongSelf.navigateToWelcome()
            }
        }
    
    private func navigateToWelcome() {
        passwordField.text=""
        loginbtn.isEnabled = false
        performSegue(withIdentifier: segueWelcome, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if(segue.identifier == segueWelcome) {
               if let userId = Auth.auth().currentUser?.uid, let email = Auth.auth().currentUser?.email{
                   let viewController = segue.destination as! WelcomeViewController
                   viewController.emailAddressInfo = email
                   viewController.userIdInfo = userId
               }
           }
       }
  
    
     func showAlert(title: String, message: String) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(controller, animated: true, completion: nil)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    

}


