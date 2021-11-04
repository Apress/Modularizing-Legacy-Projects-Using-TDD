//
//  DetailsViewController.swift
//  Demo
//
//  Created by khaled mohamed el morabea on 10/27/20.
//

import UIKit

class DetailsViewController: UIViewController {
    public var selectedCity:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = selectedCity;
    }

    @IBAction func sayHello() {
        let alertController = UIAlertController(title: "Welcome", message: "in \(self.selectedCity ?? "Invalid city")", preferredStyle: .alert)
        let action = UIAlertAction(title: "Thanks", style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
