//
//  MainViewController.swift
//  Demo
//
//  Created by khaled mohamed el morabea on 11/15/20.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet var coffeeTypesButton:UIButton?
    @IBOutlet var coffeeDrinksButton:UIButton?
    @IBOutlet var coffeeMachinesButton:UIButton?
    var presenter:MainViewPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let source = MainViewDataSource()
        let model = MainViewModel(source: source)
        self.presenter = MainViewPresenter(model: model)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fillData()
    }
    
    func fillData()  {
        guard let categories = self.presenter?.fetchAllCategories() else {
            return
        }
        
        // filling Data
        self.coffeeTypesButton?.setTitle(categories[0], for: .normal)
        self.coffeeDrinksButton?.setTitle(categories[1], for: .normal)
        self.coffeeMachinesButton?.setTitle(categories[2], for: .normal)
    }
    
    // Actions
    @IBAction func pressCoffeeTypes() {
    }
    
    @IBAction func pressCoffeeDrinks() {
        self.performSegue(withIdentifier: "coffee_drinks", sender: nil)
    }
    
    @IBAction func pressCoffeeMachines() {
        
    }

}

