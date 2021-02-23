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
    
    @IBOutlet weak var titleLabelTextView: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var readFullArticleButton: UIButton!
    
    //MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
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
