//
//  WelcomeViewController.swift
//  lab2
//
//  Created by Sangeetha Thyagarajan on 2024-06-15.
//

import UIKit
import FirebaseAuth

class WelcomeViewController: UIViewController, UINavigationControllerDelegate {
    
    var emailAddressInfo: String?
    var userIdInfo: String?
    private let segueListScreen = "goToList"

    @IBOutlet weak var emailTextView: UILabel!
    @IBOutlet weak var userIdTextView: UILabel!
    
    @IBOutlet weak var detailView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureWelcomeStyleValues()

        if let email = emailAddressInfo  {
            emailTextView.text = email
        }
        if let userId = userIdInfo {
            userIdTextView.text = userId
        }
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            if let navigationController = self.navigationController {
                       navigationController.popToRootViewController(animated: true)
                   } else {
                       dismiss(animated: true)
                   }
        } catch let logOutError  as NSError {
            print("Error logging out: \(logOutError)")
        }
    }
    
    @IBAction func nextScreenBtn(_ sender: Any) {
        performSegue(withIdentifier: segueListScreen, sender: self)
        
    }
    
    private func configureWelcomeStyleValues() {
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = "User Information"
        
        detailView?.layer.cornerRadius = 10
        detailView?.clipsToBounds = true
        
        emailTextView?.clipsToBounds = true
        emailTextView?.layer.cornerRadius = 5
        
        userIdTextView?.clipsToBounds = true
        userIdTextView?.layer.cornerRadius = 5

    }

}
