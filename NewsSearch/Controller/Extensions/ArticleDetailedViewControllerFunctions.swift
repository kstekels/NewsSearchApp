//
//  ArticleDetailedViewControllerFunctions.swift
//  NewsSearch
//
//  Created by karlis.stekels on 23/02/2021.
//

import UIKit

extension ArticleDetailedViewController {
    //MARK: - Set View - func
    func setView() {
        titleLabelTextView.text = titleLabelText
        titleLabelTextView.numberOfLines = 0
        articleImageView.image = articleImage
        descriptionTextView.text = descriptionText
        readFullArticleButton.layer.cornerRadius = 15
        readFullArticleButton.backgroundColor = .systemFill
    }
}
