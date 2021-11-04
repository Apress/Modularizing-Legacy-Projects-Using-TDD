//
//  CoffeeDetailsViewController.swift
//  Demo
//
//  Created by khaled mohamed el morabea on 14/02/2021.
//

import UIKit

class CoffeeDetailsViewController: UIViewController {
    var presenter:CoffeeDetailsPresenter?

    @IBOutlet var coffeeDrinkImageView:UIImageView?
    @IBOutlet var coffeeDrinkDescriptionTxtView:UITextView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        layout()
    }
    
    func layout() {
        self.title = self.presenter?.getName()
        self.coffeeDrinkDescriptionTxtView?.text = self.presenter?.getDescription()
        if let imageName =  self.presenter?.getImageName() {
            self.coffeeDrinkImageView?.image = UIImage(named:imageName)
        }
    }

}
