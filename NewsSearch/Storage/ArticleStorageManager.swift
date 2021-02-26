//
//  ArticleStorageManager.swift
//  NewsSearch
//
//  Created by karlis.stekels on 24/02/2021.
//

import RealmSwift
import UIKit

class ArticleStorageManager {
    let realm = try! Realm()
    
    var listOfArticleTitle:     [String] = []
    var listOfArticleImages:    [UIImage] = []
    var listOfArticleUrl:       [String] = []
        
    func deleteArticle() {
        realm.beginWrite()
        realm.delete(realm.objects(Article.self))
        try! realm.commitWrite()
    }
    
    func loadArticle() {
        let articles = realm.objects(Article.self)
        for article in articles {
            
            let articleTitle    = article.title
            let articleURL      = article.url
            let articleImage    = article.image
            
            if !listOfArticleTitle.contains(articleTitle) {
                listOfArticleUrl.append(articleURL)
                listOfArticleTitle.append(articleTitle)
                listOfArticleImages.append(UIImage(data: articleImage!)!)
            }
        }

    }
    
    func saveArticle(_ article: Article) {
        realm.beginWrite()
        realm.add(article)
        try! realm.commitWrite()
    }
}
    

