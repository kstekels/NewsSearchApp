//
//  SavedTableViewFunctions.swift
//  NewsSearch
//
//  Created by karlis.stekels on 25/02/2021.
//

import UIKit

extension SavedViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexOfUrl  = indexPath.row
        let storyboard  = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let vc    = storyboard.instantiateViewController(identifier: "WebViewControllerID") as? WebViewController else {
            return
        }
        vc.urlString = storage.listOfArticleUrl[indexOfUrl]
        
        if stateOfModalPresentation{
            self.present(vc, animated: true) 
        }
        navigationController?.pushViewController(vc, animated: true)
        
//
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let index = indexPath.row
        let titleIndex = storage.listOfArticleTitle.firstIndex(of: storage.listOfArticleTitle[index])
        let urlIndex = storage.listOfArticleUrl.firstIndex(of: storage.listOfArticleUrl[index])
        let imageIndex = storage.listOfArticleImages.firstIndex(of: storage.listOfArticleImages[index])
        
        let alert = UIAlertController(title: "Delete?", message: "Are you sure you want to delete: \"\(storage.listOfArticleTitle[index])\"", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Yes", style: .destructive) { [self] _ in
            if titleIndex != nil{
                storage.listOfArticleImages.remove(at: imageIndex!)
                storage.listOfArticleTitle.remove(at: titleIndex!)
                storage.listOfArticleUrl.remove(at: urlIndex!)
                print("Successfully removed!")
                storage.deleteArticle()
                for index in 0..<storage.listOfArticleTitle.count {
                    let newArticle      = Article()
                    newArticle.title    = storage.listOfArticleTitle[index]
                    newArticle.url      = storage.listOfArticleUrl[index]
                    newArticle.image    = storage.listOfArticleImages[index].pngData()
                    storage.saveArticle(newArticle)
                }
                    print("Successfully saved!")
                    updateView()
            }else{
                print("Item not exist")
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)

        }
    
    //Animation for cells
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotationTransform       = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
        cell.layer.transform        = rotationTransform
        cell.alpha                  = 0
        UIView.animate(withDuration: 0.75){
            cell.layer.transform    = CATransform3DIdentity
            cell.alpha              = 1
        }
    }
    
}

extension SavedViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storage.listOfArticleTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "savedCell", for: indexPath)
        
        let index = indexPath.row
        cell.textLabel?.text            = storage.listOfArticleTitle[index]
        cell.textLabel?.numberOfLines   = 0
        // from Stack Overflow
        cell.imageView?.image           = imageWithImage(image: storage.listOfArticleImages[index], scaleToSize: CGSize(width: 85, height: 50))
        
        return cell
    }
    
    
}
