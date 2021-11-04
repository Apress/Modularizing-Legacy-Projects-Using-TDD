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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadSavedData()
    }

    func loadSavedData() {
        var results = [Book]()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let request: NSFetchRequest<Book> = Book.fetchRequest()
        let sort = NSSortDescriptor(key: "created_date", ascending: false)
        request.sortDescriptors = [sort]
        do {
            results = try appDelegate.persistentContainer.viewContext.fetch(request)
            print("Got \(books.count) books")
        } catch {
            print("Fetch failed")
        }
        
        for book in results {
            books.append(convertToBookModel(book: book))
        }
        
        self.tableView?.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsA", let book = sender as? BookModel, let bookViewController = segue.destination as? BookViewControllerA {
            bookViewController.book = book;
        }
    }

    
    func convertToBookModel(book:Book) -> BookModel {
        var model = BookModel(title: book.title ?? "", contributor: book.contributor ?? "", author: book.author ?? "", createdDate: book.created_date ?? "")
        model.amazonProductURL = book.amazon_product_url ?? ""
        model.bookImage = book.book_image ?? ""
        model.bookDescription = book.desc ?? ""
        model.publisher = book.publisher ?? ""
        
        var links:[BuyLinkModel] = []
        guard let buylinks = book.buyLinks?.allObjects as? [BuyLink] else {
            return model
        }
        
        for buyLink in buylinks {
            let link = BuyLinkModel(name: BuyLinkModel.Name(rawValue: buyLink.name ?? "") ?? .amazon, url:buyLink.url ?? "")
            links.append(link)
        }
        
        model.buyLinks = links
        
        return model
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
