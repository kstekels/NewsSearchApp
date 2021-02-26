//
//  SavedViewController.swift
//  NewsSearch
//
//  Created by karlis.stekels on 24/02/2021.
//

import UIKit

class SavedViewController: UIViewController {
    
    @IBOutlet var tableView         : UITableView!
    var article                     = Article()
    var storage                     = ArticleStorageManager()
    var stateOfModalPresentation    = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate      = self
        tableView.dataSource    = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        storage.loadArticle()
        updateView()
    }
    
    
    //MARK: - InfoButton
    @IBAction func infoButtonPressed(_ sender: Any) {
            infoButtonText()
    }
    
    @IBAction func deleteAllArticlesButton(_ sender: Any) {
        deleteAllSavedArticles()
    }
    

    
    func updateView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.title = "Saved articles (\(self.storage.listOfArticleTitle.count))"
        }
    }

}


