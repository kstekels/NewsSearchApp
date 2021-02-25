//
//  ArticleDetailedViewController.swift
//  NewsSearch
//
//  Created by karlis.stekels on 23/02/2021.
//

import UIKit

class ArticleDetailedViewController: UIViewController {
        
    //MARK: - Variables && Outlets
    var titleLabelText = String()
    var articleImage: UIImage?
    var descriptionText = String()
    var urlStringForWeb = String()

    let storage = ArticleStorageManager()
    
    @IBOutlet weak var titleLabelTextView: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var readFullArticleButton: UIButton!
    @IBOutlet weak var saveArticleButton: UIButton!
    
    //MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        storage.loadArticle()
    }
    
    //MARK: - Save button for article
    @IBAction func saveArticleForLaterTapped(_ sender: Any) {
        if !storage.listOfArticleTitle.contains(titleLabelText){
            print("Save")
            saveAlert()
        }else{
            print("Dismiss")
            articleAlreadyExistAlert()
        }
        
    }
    

    
    func articleAlreadyExistAlert() {
        let alert  = UIAlertController(title: "Already in your collection!", message: "Article \"\(titleLabelText)\" is already saved in your library!", preferredStyle: .alert)
        
        let goToSavedList = UIAlertAction(title: "Go to library", style: .default) { _ in
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            guard let vc = storyboard.instantiateViewController(identifier: "SavedViewControllerID") as? SavedViewController else {
                return
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        let close = UIAlertAction(title: "Close", style: .destructive, handler: nil)
        alert.addAction(close)
        alert.addAction(goToSavedList)
        present(alert, animated: true, completion: nil)
    }
    
    func saveAlert() {
        let alert = UIAlertController(title: "Save?", message: "Do you want to save this article?", preferredStyle: .actionSheet)
        let saveAction = UIAlertAction(title: "Yes", style: .default) { [self] _ in
            saveCurrentArticle()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func savedNotification() {
        let alert = UIAlertController(title: "Success!", message: "Article is added to your library! 😌", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func saveCurrentArticle() {
        
        let currentArticle = Article()
        
        currentArticle.image = articleImage?.pngData()
        currentArticle.url = urlStringForWeb
        currentArticle.title = titleLabelText
        storage.saveArticle(currentArticle)
        savedNotification()
        
        storage.listOfArticleTitle.append(titleLabelText)

    }
    

    
    //MARK: - Read Full article button Action
    @IBAction func goToArticleButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let vc = storyboard.instantiateViewController(identifier: "WebViewControllerID") as? WebViewController else {
            return
        }
        vc.urlString = urlStringForWeb
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
