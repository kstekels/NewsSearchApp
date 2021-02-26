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
        let saved = SavedViewController()
        titleLabelTextView.text                     = titleLabelText
        titleLabelTextView.numberOfLines            = 0
        articleImageView.image                      = articleImage
        descriptionTextView.text                    = descriptionText
        
        readFullArticleButton.layer.cornerRadius    = 15
        readFullArticleButton.backgroundColor       = .systemFill
        saveArticleButton.layer.cornerRadius        = 15
        saveArticleButton.backgroundColor           = .systemFill
        saved.stateOfModalPresentation              = false
    }
    
    func articleAlreadyExistAlert() {
        let alert  = UIAlertController(title: "Hey!👋",
                                       message: "This article \"\(titleLabelText)\" is already saved in your library!",
                                       preferredStyle: .alert)
        
        let goToSavedList = UIAlertAction(title: "Go to library", style: .default) { _ in
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            guard let vc = storyboard.instantiateViewController(identifier: "SavedViewControllerID") as? SavedViewController else {
                return
            }

            vc.stateOfModalPresentation = true
            self.present(vc, animated: true, completion: nil)
        }
        let close = UIAlertAction(title: "Close", style: .destructive, handler: nil)
        alert.addAction(close)
        alert.addAction(goToSavedList)
        present(alert, animated: true, completion: nil)
    }
    
    func saveAlert() {
        let alert = UIAlertController(title: "Save?", message: "Do you want to add this article to your library?", preferredStyle: .actionSheet)
        let saveAction = UIAlertAction(title: "Yes", style: .default) { [self] _ in
            saveCurrentArticle()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func savedNotification() {
        let alert = UIAlertController(title: "Successful!", message: "Article is added to your library!👌", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func saveCurrentArticle() {
        let currentArticle          = Article()
        currentArticle.image        = articleImage?.pngData()
        currentArticle.url          = urlStringForWeb
        currentArticle.title        = titleLabelText
        storage.saveArticle(currentArticle)
        savedNotification()
        storage.listOfArticleTitle.append(titleLabelText)

    }

    
}
