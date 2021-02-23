//
//  WebViewController.swift
//  NewsSearch
//
//  Created by karlis.stekels on 23/02/2021.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet weak var webKit: WKWebView!
    

    var urlString = String()
    
    override func loadView() {
        webKit = WKWebView()
        webKit.navigationDelegate = self
        view = webKit
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title.self = "Web View"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        webKit.load(URLRequest(url: url))
        webKit.allowsBackForwardNavigationGestures = true
        
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Navigation is started")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Navigation is stopped")
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

