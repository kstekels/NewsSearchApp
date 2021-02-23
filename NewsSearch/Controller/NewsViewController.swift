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
    
    //MARK: - Outlets && Variables
    @IBOutlet weak var tableView: UITableView!
    var items: [Items] = []
    var newsTopic = String()
    var image = UIImage()
    var animationIsShowedOnce = Bool()
    var totalResult = 1
    var titleText = String()

    //MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNewsView()
    }

    //MARK: - View Did Appear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (timer1) in
            self.animatedTitle()
        }
        
    }
}


