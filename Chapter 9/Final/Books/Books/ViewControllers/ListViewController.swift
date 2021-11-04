//
//  ListViewController.swift
//  Books
//
//  Created by khaled mohamed el morabea on 01/05/2021.
//

import UIKit

protocol ListFilterDelegate: AnyObject {
    func listSelected(_ list: List)
}

class ListViewController: UIViewController {

    public var listNames:[List]?
    weak var delegate: ListFilterDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}

extension ListViewController :UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let list = self.listNames?[indexPath.row] {
            self.delegate?.listSelected(list)
            self.dismiss(animated: true, completion: nil)
        }
    }
}

extension ListViewController :UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.listNames?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "list")!
        
        if let list = self.listNames?[indexPath.row] {
            cell.textLabel?.text = list.displayName
        }
        
        return cell
    }
}
