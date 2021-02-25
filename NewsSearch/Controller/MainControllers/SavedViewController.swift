//
//  SavedViewController.swift
//  NewsSearch
//
//  Created by karlis.stekels on 24/02/2021.
//

import UIKit

class SavedViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    var article = Article()
    var storage = ArticleStorageManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Saved articles"
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        storage.loadArticle()
        updateView()
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: - InfoButton
    @IBAction func infoButtonPressed(_ sender: Any) {
            let alert = UIAlertController(title: "Info!", message: "In this section you will find all saved articles!\nIf you want to delete them, then you must swipe from right to the left side on choosen article and tap delete!\nIf you want clear the library, then press on trash can, which located right upper corner!", preferredStyle: .alert)
            let close = UIAlertAction(title: "Close", style: .cancel, handler: nil)
            alert.addAction(close)
            present(alert, animated: true)
        }
    
    @IBAction func deleteAllArticlesButton(_ sender: Any) {
        
        if storage.listOfArticleTitle.count != 0{
            let alert = UIAlertController(title: "Delete All? 🤭", message: "Are you sure you want to delete all articles?", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            let deleteAll = UIAlertAction(title: "Delete All", style: .destructive) { _ in
                self.storage.deleteArticle()
                print("All deleted")
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
    
    
    func updateView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    // from stackoverflow
    func imageWithImage(image: UIImage, scaleToSize newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(newSize)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!.withRenderingMode(.alwaysOriginal)
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

extension SavedViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You pressed: \(indexPath.row)")
        let indexOfUrl = indexPath.row
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let vc = storyboard.instantiateViewController(identifier: "WebViewControllerID") as? WebViewController else {
            return
        }
        vc.urlString = storage.listOfArticleUrl[indexOfUrl]
        
        navigationController?.pushViewController(vc, animated: true)
        
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
                    let newArticle = Article()
                    newArticle.title = storage.listOfArticleTitle[index]
                    newArticle.url = storage.listOfArticleUrl[index]
                    newArticle.image = storage.listOfArticleImages[index].pngData()
                    storage.saveArticle(newArticle)
                }
                    print("Successfully saved!")
                    tableView.reloadData()
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
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0
        UIView.animate(withDuration: 0.75){
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1
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
        cell.textLabel?.text = storage.listOfArticleTitle[index]
        cell.textLabel?.numberOfLines = 0
        cell.imageView?.image = imageWithImage(image: storage.listOfArticleImages[index], scaleToSize: CGSize(width: 85, height: 50))
        
        return cell
    }
    
    
}
