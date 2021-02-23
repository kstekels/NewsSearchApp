//
//  ArticleDetailedViewController.swift
//  NewsSearch
//
//  Created by karlis.stekels on 23/02/2021.
//

import UIKit

class ArticleDetailedViewController: UIViewController {
    
    var titleLabelText = String()
    var articleImage: UIImage?
    var descriptionText = String()
    var urlStringForWeb = String()
    
    @IBOutlet weak var titleLabelTextView: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    func setView() {
        titleLabelTextView.text = titleLabelText
        titleLabelTextView.numberOfLines = 0
        articleImageView.image = articleImage
        descriptionTextView.text = descriptionText
    }
    
    @IBAction func goToArticleButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let vc = storyboard.instantiateViewController(identifier: "WebViewControllerID") as? WebViewController else {
            return
        }
        
        vc.urlString = urlStringForWeb
        
        navigationController?.pushViewController(vc, animated: true)

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
