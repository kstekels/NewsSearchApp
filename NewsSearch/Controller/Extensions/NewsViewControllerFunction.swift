//
//  NewsViewControllerExtension.swift
//  NewsSearch
//
//  Created by karlis.stekels on 23/02/2021.
//

import UIKit
import Gloss
import SkeletonView

extension NewsViewController {
    //MARK: - Setup view
    func setupNewsView() {
        self.title                      = "Loading..."
        tableView.delegate              = self
        tableView.dataSource            = self
        tableView.isSkeletonable        = true
        animationIsShowedOnce           = false
        getDataFromJson()
        tableView.rowHeight             = 100
        tableView.estimatedRowHeight    = 100

        tableView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .darkClouds), animation: nil, transition: .crossDissolve(0.25))
    }
    
    //MARK: - self.title Animation
    func animatedTitle(){
        if !animationIsShowedOnce{
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (timer) in
                self.title = ""
                var charIndex = 0.0
                if self.totalResult > 0{
                    if self.newsTopic.capitalized == "Apple" {
                        self.titleText = "\(self.newsTopic.capitalized) 🍏"
                    }else{
                        self.titleText = "\(self.newsTopic.capitalized)"
                    }
                    
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

    //MARK: - No result is found - func
    func ifNothingFound(for search: String) {
        let alert = UIAlertController(title: "404. Page not Found", message: "Article:  \"\(search)\" not found", preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Close", style: .default) { _ in

            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(closeAction)
        present(alert, animated: true)
        
    }

    //MARK: - JSON data parsing
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
                print("Error converting JSON")
            }
        }
        task.resume()
    }
    
    //MARK: - Populate Data
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
