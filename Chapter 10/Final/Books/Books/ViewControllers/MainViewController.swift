//
//  MainViewController.swift
//  Books
//
//  Created by khaled mohamed el morabea on 01/05/2021.
//

import UIKit

class MainViewController: UIViewController {
    var lists:[List]? = []
    var filteredBooks:[List]? = []
    var isFiltered:Bool = false
    var refreshControl = UIRefreshControl()
    private var mainViewPresenter:MainViewPresenter?

    @IBOutlet var tableView:UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "All lists"
        let network = NetworkLayer()
        let mainViewModel = MainViewModel(network: network)
        self.mainViewPresenter = MainViewPresenter(mainViewModel: mainViewModel)
        

        let bookMarks = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(goToFavs))
        let filterSymbol = UIImage(named: "line.horizontal.3.decrease.circle")
        
        let filter = UIBarButtonItem(image: filterSymbol, style: .plain, target: self, action: #selector(showFilterView))

        navigationItem.rightBarButtonItems = [bookMarks, filter]
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.tableView?.addSubview(refreshControl)
        fetchBooks()
    }
    
    @objc func refresh(_ sender: AnyObject) {
        fetchBooks()
    }
    
    @IBAction func goToFavs() {
        self.performSegue(withIdentifier: "fav", sender: nil)
    }
    
    @IBAction func showFilterView() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let filterView = sb.instantiateViewController(withIdentifier: "list") as? ListViewController
        filterView?.delegate = self
        filterView?.listNames = self.lists
        filterView?.listNames?.insert(List(listID: 0, listName: "All", displayName: "All", books: []), at: 0)
        self.present(filterView!, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsA", let book = sender as? BookModel, let bookViewController = segue.destination as? BookViewControllerA {
            bookViewController.book = book;
        } else if segue.identifier == "detailsB", let book = sender as? BookModel, let bookViewController = segue.destination as? BookViewControllerB {
            bookViewController.book = book;
        }
    }
    
    func fetchBooks() {
        self.mainViewPresenter?.fetchBestSellerBooks(callBack: { lists in
            if let lists = lists {
                self.lists = lists
                DispatchQueue.main.async {
                    self.refreshControl.endRefreshing()
                    self.tableView?.reloadData()
                }
            }
        })
    }
}

extension MainViewController :ListFilterDelegate {
    func listSelected(_ list: List) {
        isFiltered = list.listName != "All"
        filterLists(withList: list)
    }
    
    func filterLists(withList list:List) {
        self.filteredBooks = self.lists?.filter({ toBeFilteredList in
            return toBeFilteredList.listName == list.listName
        })
        
        DispatchQueue.main.async {
            self.tableView?.reloadData()
        }
    }
}

extension MainViewController :UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let list = self.getLists()?[indexPath.section] else {
            return
        }
        
        self.performSegue(withIdentifier: "detailsA", sender: list.books[indexPath.row])
    }
}

extension MainViewController :UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.getLists()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.getLists()?[section].listName ?? ""
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let list = self.getLists()?[section] {
            return list.books.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "book") as! BookTableViewCell
        cell.bookImg?.image = nil
        
        guard let list = self.getLists()?[indexPath.section] else {
            return cell
        }
        
        let book = list.books[indexPath.row]
        
        cell.title?.text = book.title
        cell.desc?.text = book.bookDescription
        cell.date?.text = book.createdDate
        if let url = URL(string: book.bookImage!) {
            cell.bookImg?.load(url: url)
        }
        
        cell.assignAccess(index: indexPath.row)
        
        return cell
    }
    
    func getLists() -> [List]? {
        if self.isFiltered {
            return self.filteredBooks
        } else {
            return self.lists
        }
    }
}
