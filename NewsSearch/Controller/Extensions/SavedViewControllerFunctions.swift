//
//  SavedViewControllerFunctions.swift
//  NewsSearch
//
//  Created by karlis.stekels on 25/02/2021.
//

import UIKit

extension SavedViewController {
    
    //MARK: - Info Button
    func infoButtonText() {
        let alert = UIAlertController(title: "Info!👇",
                                      message: "In this library, you will find all saved articles!\n\nIf you want to delete article, then swipe from right to left side!\n\nIf you want erease all content in your library, then press on trash can, which located right upper corner!",
                                      preferredStyle: .alert)
        
        let close = UIAlertAction(title: "Close", style: .cancel, handler: nil)
        alert.addAction(close)
        present(alert, animated: true)
    }
    
    //MARK: - Delete All
    func deleteAllSavedArticles() {
        if storage.listOfArticleTitle.count != 0 {
            let alert       = UIAlertController(title: "Delete All? 🤭", message: "Are you sure you want to delete all articles?", preferredStyle: .alert)
            let cancel      = UIAlertAction(title: "Cancel", style: .cancel)
            let deleteAll   = UIAlertAction(title: "Delete All", style: .destructive) { _ in
                self.storage.deleteArticle()
                self.storage.listOfArticleTitle.removeAll()
                self.storage.listOfArticleUrl.removeAll()
                self.storage.listOfArticleImages.removeAll()
                self.updateView()
            }
            
            alert.addAction(cancel)
            alert.addAction(deleteAll)
            present(alert, animated: true) { [self] in
                updateView()
            }
        }
    }
    
    // from Stack Overflow
    func imageWithImage(image: UIImage, scaleToSize newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(newSize)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!.withRenderingMode(.alwaysOriginal)
    }
    
}
