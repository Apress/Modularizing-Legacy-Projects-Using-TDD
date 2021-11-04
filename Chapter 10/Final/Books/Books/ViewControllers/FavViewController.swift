//
//  FavViewController.swift
//  Books
//
//  Created by khaled mohamed el morabea on 01/05/2021.
//

import UIKit
import CoreData

class FavViewController: UIViewController {

    var books = [BookModel]()
    @IBOutlet var tableView:UITableView?
    private var favViewPresenter:FavoriteViewPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        let favoriteViewModel = FavoriteViewModel(favoritesManager: FavoritesManager.shared)
        self.favViewPresenter = FavoriteViewPresenter(favoriteViewModel: favoriteViewModel)

        // Do any additional setup after loading the view.
        loadSavedData()
    }

    func loadSavedData() {
        books = self.favViewPresenter?.fetchAllFavorites() ?? []
        self.tableView?.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsA", let book = sender as? BookModel, let bookViewController = segue.destination as? BookViewControllerA {
            bookViewController.book = book;
        }
    }
}

extension FavViewController :UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = self.books[indexPath.row]
        self.performSegue(withIdentifier: "detailsA", sender: book)
    }
}

extension FavViewController :UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "book") as! BookTableViewCell
        cell.bookImg?.image = nil
        
        let book = self.books[indexPath.row]
        cell.title?.text = book.title
        cell.desc?.text = book.bookDescription
        cell.date?.text = book.createdDate
        if let url = URL(string: book.bookImage!) {
            cell.bookImg?.load(url: url)
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let book = self.books[indexPath.row]
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let request: NSFetchRequest<Book> = Book.fetchRequest()
            request.predicate = NSPredicate(format: "title == %@",book.title ?? "")
            request.fetchLimit = 1
            var results:[Book] = []
            do {
                results = try appDelegate.persistentContainer.viewContext.fetch(request)
                print("Got \(books.count) books")
            } catch {
                print("Fetch failed")
            }
            
            appDelegate.persistentContainer.viewContext.delete(results.first!)
            self.books.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)

            appDelegate.saveContext()
        }
    }
}
