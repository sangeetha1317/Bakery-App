//
//  DescriptionViewController.swift
//  lab2
//
//  Created by Sangeetha Thyagarajan on 2024-06-15.
//

import UIKit

class DescriptionViewController: UIViewController {
    var descriptionTextCell: String?
    var titleTextCell: String?
    var imageCell: String?
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var foodImageView: UIImageView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        configureDescriptionStyleValues()
        
        if let descmessage = descriptionTextCell {
            descriptionLabel.text = descmessage
        }
        if let titlemessage = titleTextCell {
            titleLabel.text = titlemessage
        }
        
        if let foodImage = imageCell {
            foodImageView.image = UIImage(named: foodImage)
        }
    }
    
    private func configureDescriptionStyleValues() {
        self.navigationItem.title = titleTextCell
        
        foodImageView.layer.cornerRadius = 10
        foodImageView.clipsToBounds = true
        
        descriptionLabel.layer.cornerRadius = 10
        descriptionLabel.clipsToBounds = true
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "house"), style: .plain, target: self, action: #selector(didTapHome))
    }
    
    @objc private func didTapHome() {
        if let navigationController = self.navigationController {
            for controller in navigationController.viewControllers {
                if controller is WelcomeViewController {
                    navigationController.popToViewController(controller, animated: true)
                    return
                }
            }
        }
    }
}
