//
//  NewsTableViewCell.swift
//  NewsSearch
//
//  Created by karlis.stekels on 22/02/2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var titleLabelForCell: UILabel!
    @IBOutlet weak var imageViewForCell: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
