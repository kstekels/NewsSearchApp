//
//  LaunchScreenController.swift
//  NewsSearch
//
//  Created by karlis.stekels on 25/02/2021.
//

import UIKit

class LaunchScreenController: UIViewController {
    
    @IBOutlet weak var loadingLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 2) {
            self.loadingLabel.transform = CGAffineTransform(translationX: 0, y: self.view.bounds.size.height)
            self.view.backgroundColor = UIColor.white
        }
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateInitialViewController()
        UIApplication.shared.keyWindow?.rootViewController = vc
    }
    
}
