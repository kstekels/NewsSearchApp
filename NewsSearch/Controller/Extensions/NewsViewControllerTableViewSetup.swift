//
//  NewsViewControllerTableViewSetup.swift
//  NewsSearch
//
//  Created by karlis.stekels on 23/02/2021.
//

import UIKit
import Gloss
import SkeletonView

//MARK: - EXTENSION
extension NewsViewController: UITableViewDelegate, SkeletonTableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        "NewsCell"
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsTableViewCell else { return UITableViewCell() }
        
        let item = items[indexPath.row]
        
        if let image = item.image {
            cell.imageViewForCell.image = image
        }
        cell.titleLabelForCell.text = item.title

        if items.count == 0 {
            self.presentingViewController?.dismiss(animated: true)
        }
        print(ArticleStorageManager().listOfArticleTitle)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let vc = storyboard.instantiateViewController(identifier: "ArticleDetailedViewControllerID") as? ArticleDetailedViewController else {
            return
        }
        
        vc.articleImage = items[indexPath.row].image
        vc.descriptionText = items[indexPath.row].description
        vc.titleLabelText = items[indexPath.row].title
        vc.urlStringForWeb = items[indexPath.row].url
    
        navigationController?.pushViewController(vc, animated: true)
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
