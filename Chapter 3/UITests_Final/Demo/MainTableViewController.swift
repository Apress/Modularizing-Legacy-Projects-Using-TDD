//
//  MainTableViewController.swift
//  Demo
//
//  Created by khaled mohamed el morabea on 10/27/20.
//

import UIKit

class MainTableViewController: UITableViewController {
    let array = ["San Francisco", "San Jose", "Palo Alto", "Mountain view", "Cupertino", "Santa Carla"]
    var selection:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Cities";
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return array.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "identifier", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = array[indexPath.row]

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selection = array[indexPath.row]
        self.performSegue(withIdentifier: "show", sender: nil)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "show" {
            if let viewController = segue.destination as? DetailsViewController {
                viewController.selectedCity = self.selection
            }
        }
    }

}
