//
//  ListViewController.swift
//  lab2
//
//  Created by Sangeetha Thyagarajan on 2024-06-15.
//

import UIKit

class ListViewController: UIViewController {
     let segueDescriptionScreen = "goToDescription"
     var selectedTitle: String?
     var selectedDescription: String?
     var selectedImage: String?


    let arr = [
        [
        "title":"Croissants" ,
        "description":"Flaky, buttery pastries with a golden brown exterior, perfect for breakfast or a snack.",
        "image": "Croissants"
        ],
        [
        "title":"Chocolate Chip Cookies" ,
        "description":"Classic cookies filled with gooey chocolate chips, crispy on the edges and chewy in the center.",
        "image": "Chocolatechipcookies"

        ],
        [
        "title":"Blueberry Muffins" ,
        "description":"Moist and fluffy muffins bursting with fresh blueberries, topped with a crunchy sugar crust.",
        "image": "Blueberry"

        ],
        [
        "title":"Cinnamon Rolls" ,
        "description":"Soft, sweet rolls filled with cinnamon and brown sugar, drizzled with a creamy icing.",
        "image": "Cinnamonrolls"

        ],
        [
        "title":"Sourdough Bread" ,
        "description":"Crusty, tangy sourdough loaf with a chewy interior, perfect for sandwiches or toasting.",
        "image": "Sourdoughbread"

        ],
        [
        "title":"Apple Pie" ,
        "description":"Traditional pie with a flaky crust and a sweet apple filling spiced with cinnamon and nutmeg.",
        "image": "Applepie"

        ],
        [
        "title":"Bagels" ,
        "description":"Chewy, round bread rolls with a dense interior and crispy exterior, available in flavors like plain, sesame, and everything.",
        "image": "Bagels"

        ],
        [
        "title":"Red Velvet Cupcakes" ,
        "description":"Rich, velvety cupcakes with a hint of cocoa, topped with cream cheese frosting.",
        "image": "Redvelvetcupcakes"

        ],
        [
        "title":"Scones" ,
        "description":"Crumbly and slightly sweet pastries that can be enjoyed plain or with fruits or chocolate chips.",
        "image": "Scones"

        ],
        [
        "title":"Brownies" ,
        "description":"Dense, fudgy chocolate squares with a rich, moist texture, often featuring a crispy top and various mix-ins.",
        "image": "Brownies"
        ]
    ]
    
    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.delegate = self
        listTableView.dataSource = self

        configureListStyleValues()
    }
    
    private func configureListStyleValues() {
        self.navigationItem.title = "Bakery List"
        self.navigationItem.backButtonTitle = "Back"
        listTableView.layer.cornerRadius = 5
        listTableView.clipsToBounds = true
    }
   
}

extension ListViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCellIdentifier", for: indexPath) as? ListTableViewCell
  
        cell?.titleLabel.text = arr[indexPath.row]["title"]
        cell?.descriptionLabel.text = arr[indexPath.row]["description"]
        cell?.listImageView.image = UIImage(named: arr[indexPath.row]["image"] ?? "Croissants")
        cell?.listImageView.layer.cornerRadius = 20
        cell?.listImageView.clipsToBounds = true
        
        
        return cell ?? UITableViewCell()
    }
}


extension ListViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
        
            selectedDescription = arr[indexPath.row]["description"]
            selectedTitle = arr[indexPath.row]["title"]
            selectedImage = arr[indexPath.row]["image"]
            performSegue(withIdentifier: segueDescriptionScreen, sender: self)
        }

        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == segueDescriptionScreen {
                let destinationVC = segue.destination as? DescriptionViewController
                destinationVC?.descriptionTextCell = selectedDescription
                destinationVC?.titleTextCell = selectedTitle
                destinationVC?.imageCell = selectedImage
            }
        }
}
