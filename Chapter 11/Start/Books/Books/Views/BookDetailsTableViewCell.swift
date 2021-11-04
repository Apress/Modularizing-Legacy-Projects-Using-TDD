//
//  BookDetailsTableViewCell.swift
//  Books
//
//  Created by khaled mohamed el morabea on 08/05/2021.
//

import UIKit

class BookDetailsTableViewCell: UITableViewCell {
    @IBOutlet var title:UILabel?
    @IBOutlet var value:UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
