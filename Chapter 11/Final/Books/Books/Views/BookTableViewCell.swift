//
//  BookTableViewCell.swift
//  Books
//
//  Created by khaled mohamed el morabea on 01/05/2021.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    @IBOutlet var bookImg:UIImageView?
    @IBOutlet var title:UILabel?
    @IBOutlet var desc:UILabel?
    @IBOutlet var date:UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func assignAccess(index:Int) {
        self.isAccessibilityElement = false
        
        self.title?.isAccessibilityElement = true
        self.title?.accessibilityIdentifier = "book_title_\(index)"
        
        self.desc?.isAccessibilityElement = true
        self.desc?.accessibilityIdentifier = "book_desc_\(index)"

        
        self.date?.isAccessibilityElement = true
        self.date?.accessibilityIdentifier = "book_date_\(index)"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
