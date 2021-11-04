//
//  CoffeeDrinksViewController.swift
//  Demo
//
//  Created by khaled mohamed el morabea on 13/02/2021.
//

import UIKit

class CoffeeDrinksViewController: UIViewController {
    var presenter:CoffeeDrinksPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Coffee pot"
        let source = CoffeeDrinksDataSource()
        let model = CoffeeDrinksModel(source: source)
        self.presenter = CoffeeDrinksPresenter(model: model)
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let drink = sender as? CoffeeDrink, let coffeeDetailsViewController = segue.destination as? CoffeeDetailsViewController {
            let presenter = CoffeeDetailsPresenter(drink: drink)
            coffeeDetailsViewController.presenter = presenter;
        }
    }
}

extension CoffeeDrinksViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                            UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  100
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
    }
}

extension CoffeeDrinksViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.presenter?.getDrinksCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "coffee_cell",for: indexPath) as! CoffeeDrinkViewCell
        // Configure the cell
        cell.coffeeDrinkLabel?.text = self.presenter?.getDrinkName(index: indexPath.row) ?? ""
        cell.accessibilityLabel = self.presenter?.getDrinkName(index: indexPath.row) ?? ""
        
        if let imageName =  self.presenter?.getDrinkImageName(index: indexPath.row) {
            cell.coffeeDrinkImageView?.image = UIImage(named:imageName)
        }

        return cell
    }
}

extension CoffeeDrinksViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let drink = self.presenter?.getDrink(index: indexPath.row)
        self.performSegue(withIdentifier: "coffee_detail", sender: drink)
    }
}
