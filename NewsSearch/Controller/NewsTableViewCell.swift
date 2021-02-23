//
//  NewsTableViewCell.swift
//  NewsSearch
//
//  Created by karlis.stekels on 22/02/2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabelForCell: UILabel!
    @IBOutlet weak var imageViewForCell: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
