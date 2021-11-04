//
//  BookViewControllerA.swift
//  Books
//
//  Created by khaled mohamed el morabea on 01/05/2021.
//

import UIKit
import SafariServices

class BookViewControllerA: UIViewController {
    @IBOutlet var bookImg:UIImageView?
    @IBOutlet var desc:UILabel?
    @IBOutlet var date:UILabel?
    @IBOutlet var tableView:UITableView?
    @IBOutlet var buyHeaderLabel:UILabel?
    @IBOutlet var amazonBtn:UIButton?
    @IBOutlet var appleBooksBtn:UIButton?
    @IBOutlet var barnesAndNobleBtn:UIButton?
    @IBOutlet var booksAMillionBtn:UIButton?
    @IBOutlet var bookshopBtn:UIButton?
    @IBOutlet var indieBoundBtn:UIButton?
    private var bookViewPresenter:BookViewPresenter?

    public var book:BookModel?
    var bookDetails:[[String:String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let networkLayer = NetworkLayer()
        let bookViewModel = BookViewModel(network: networkLayer, favoritesManager: FavoritesManager.shared)
        self.bookViewPresenter = BookViewPresenter(bookViewModel: bookViewModel)

        self.title = self.book?.title
        self.desc?.text = self.book?.bookDescription
        self.date?.text = self.book?.createdDate
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCurrentBookToFavorites))


        if let bookImage = self.book?.bookImage,  let url = URL(string: bookImage) {
            self.bookImg?.load(url: url)
        }
        
        fillBookDetails()
        // Do any additional setup after loading the view.
        
        customizePurchaseButtos(btn: self.amazonBtn)
        customizePurchaseButtos(btn: self.appleBooksBtn)
        customizePurchaseButtos(btn: self.barnesAndNobleBtn)
        customizePurchaseButtos(btn: self.booksAMillionBtn)
        customizePurchaseButtos(btn: self.bookshopBtn)
        customizePurchaseButtos(btn: self.indieBoundBtn)
    }
    
    func fillBookDetails() {
        self.bookDetails.append(["Author": self.book?.author ?? ""])
        self.bookDetails.append(["Contributor": self.book?.contributor ?? ""])
        self.bookDetails.append(["Primary isbn10": self.book?.primaryIsbn10 ?? ""])
        self.bookDetails.append(["Primary isbn13": self.book?.primaryIsbn13 ?? ""])
        self.bookDetails.append(["Publisher": self.book?.publisher ?? ""])
        self.bookDetails.append(["Rank": "\(self.book?.rank ?? 0)"])
        self.bookDetails.append(["Updated date": self.book?.updatedDate ?? ""])
    }
    
    func customizePurchaseButtos(btn:UIButton?) {
        btn?.backgroundColor = UIColor.clear
        btn?.layer.cornerRadius = 10.0
        btn?.layer.masksToBounds = true
        btn?.layer.borderWidth = 1
        btn?.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    @IBAction func addCurrentBookToFavorites() {
        // add to favorites
        self.saveBookAsFavorite(withBook: self.book!)
    }
    
    @IBAction func buyByAmazon() {
        for buyLink in self.book!.buyLinks! {
            if buyLink.name == .amazon {
                if let url = URL(string: buyLink.url) {
                    UIApplication.shared.open(url)
                }
            }
        }
    }
    
    @IBAction func buyByAppleBooks() {
        guard let buyLinks = self.book?.buyLinks else {
            return
        }
        
        for buyLink in buyLinks {
            if buyLink.name == .appleBooks {
                if let url = URL(string: buyLink.url) {
                    UIApplication.shared.open(url)
                }
            }
        }
    }
    
    @IBAction func buyByBarnesAndNoble() {
        guard let buyLinks = self.book?.buyLinks else {
            return
        }
        
        for buyLink in buyLinks {
            if buyLink.name == .barnesAndNoble {
                if let url = URL(string: buyLink.url) {
                    UIApplication.shared.open(url)
                }
            }
        }
    }
    
    @IBAction func buyByBooksAMillion() {
        guard let buyLinks = self.book?.buyLinks else {
            return
        }
        
        for buyLink in buyLinks {
            if buyLink.name == .booksAMillion {
                if let url = URL(string: buyLink.url) {
                    UIApplication.shared.open(url)
                }
            }
        }
    }
    
    @IBAction func buyByBookshop() {
        guard let buyLinks = self.book?.buyLinks else {
            return
        }
        
        for buyLink in buyLinks {
            if buyLink.name == .bookshop {
                if let url = URL(string: buyLink.url) {
                    UIApplication.shared.open(url)
                }
            }
        }
    }
    
    @IBAction func buyByIndieBound() {
        guard let buyLinks = self.book?.buyLinks else {
            return
        }
        
        for buyLink in buyLinks {
            if buyLink.name == .bookshop {
                if let url = URL(string: buyLink.url) {
                    UIApplication.shared.open(url)
                }
            }
        }
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

extension BookViewControllerA :UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.bookDetails[indexPath.row]
        if item.keys.first == "Author" {
            fetchAuthorData(withName: item.values.first!)
        }
    }
}

extension BookViewControllerA :UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.bookDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "details") as! BookDetailsTableViewCell
        let item = self.bookDetails[indexPath.row]
        cell.title?.text = item.keys.first
        cell.value?.text = item.values.first
        
        return cell
    }
}

extension BookViewControllerA {

    func fetchAuthorData(withName name:String) {
        let APIKEY = "YOUR_API_KEY"
        assert(APIKEY != "YOUR_API_KEY", "You need to replace \"YOUR_API_KEY\" with an actual API key. Check the project's README for steps on how to obtain one.")
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.nytimes.com"
        components.path = "/svc/books/v3/reviews.json"
        components.queryItems = [URLQueryItem(name: "api-key", value: APIKEY), URLQueryItem(name: "author", value: name)]

        guard let url = components.url else {
            preconditionFailure("Failed to construct URL")
        }

        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            guard let data = data else {
                return
            }
            
            var response:AuthorResponse?
            do {
                response = try JSONDecoder().decode(AuthorResponse.self, from: data)
            } catch {
                print(error.localizedDescription)
            }
            
            DispatchQueue.main.async {
                if let path = response?.results.first?.url, let url = URL(string: path) {
                    let safariViewController = SFSafariViewController(url: url)
                    self.navigationController?.pushViewController(safariViewController, animated: true)
                }
            }
            
        }
        
        task.resume()
    }
}

extension BookViewControllerA {

    func saveBookAsFavorite(withBook bookModel:BookModel) {
        self.bookViewPresenter?.addFavorite(bookModel)
        let alert = UIAlertController(title: "Saved", message: "Your book saved to favoriets", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
