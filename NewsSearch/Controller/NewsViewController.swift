//
//  NewsViewController.swift
//  NewsSearch
//
//  Created by karlis.stekels on 22/02/2021.
//

import UIKit
import Gloss
import SkeletonView

class NewsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var items: [Items] = []
    var newsTopic = String()
    var image = UIImage()
    var animationIsShowedOnce = Bool()
    var totalResult = Int()
    var titleText = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        animationIsShowedOnce = false
        getDataFromJson()
        tableView.rowHeight = 100
        tableView.estimatedRowHeight = 100
        tableView.dataSource = self
        tableView.isSkeletonable = true
        tableView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .link), animation: nil, transition: .crossDissolve(0.25))
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animatedTitle()
    }
    
    func animatedTitle(){
        if !animationIsShowedOnce{
            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (timer) in
                self.title = ""
                var charIndex = 0.0
                if self.totalResult > 0{
                    self.titleText = "Results for: \(self.newsTopic.capitalized)"
                }else{
                    self.tableView.isHidden = true
                    self.ifNothingFound(for: "\(self.newsTopic.capitalized)")
                }
                for letter in self.titleText{
                    Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
                        self.title?.append(letter)
                    }
                    charIndex += 1
                }
                self.animationIsShowedOnce = true
            }
        }
        
        
        
    }

    func ifNothingFound(for search: String) {
        let alert = UIAlertController(title: "Sorry!", message: "We found nothing for: \"\(search)\"", preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Close", style: .default) { _ in
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            guard let vc = storyboard.instantiateViewController(identifier: "SearchViewControllerID") as? SearchViewController else {
                return
            }
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        alert.addAction(closeAction)
        
        present(alert, animated: true)
    }

    
    func getDataFromJson() {
        let jsonURL = "https://newsapi.org/v2/everything?q=\(newsTopic)&language=en&apiKey=a473de0095844441bc54bd266083c4f3"
        
        guard let url = URL(string: jsonURL) else {
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: urlRequest) { [self] (data, response, error) in
            
            if let err = error{
                print("error: \(err.localizedDescription)")
            }
            
            guard let data = data else {
                print("Something went wrong with JSON parsing!")
                
                
                return
            }
            
            do{
                if let dictData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print("dictData:", dictData)
                    self.totalResult = dictData["totalResults"] as! Int
                    self.populateData(dictData)
                }
            }catch{
                print("Error coverting JSON")
            }
        }
        task.resume()
    }
    
    
    

    
    func populateData(_ dict: [String: Any]){
        guard let responseDict = dict["articles"] as? [Gloss.JSON] else {
            return
        }
        
        items = [Items].from(jsonArray: responseDict) ?? []
        
        DispatchQueue.main.async {
            self.tableView.stopSkeletonAnimation()
            self.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
            self.tableView.reloadData()

        }
        
    }
     

}

extension NewsViewController: UITableViewDelegate, SkeletonTableViewDataSource {
    
    // MARK: - Table view data source
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
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
        
        
        if items.count == 0{
            self.presentingViewController?.dismiss(animated: true)
        }
        
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        //Animation
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -30, 50, 20)
        cell.layer.transform = rotationTransform
        cell.alpha = 0
        UIView.animate(withDuration: 0.75){
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1
        }
        
    }


}


