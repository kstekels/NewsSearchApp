//
//  WebViewController.swift
//  NewsSearch
//
//  Created by karlis.stekels on 23/02/2021.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    
    //MARK: - Variables && Outlets
    @IBOutlet weak var webKit: WKWebView!
    var urlString = String()
    
    //MARK: - Load View
    override func loadView() {
        webKit                      = WKWebView()
        webKit.navigationDelegate   = self
        view                        = webKit
    }
    
    //MARK: - View Did load
    override func viewDidLoad() {
        super.viewDidLoad()
        title.self = "Web View"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        webKit.load(URLRequest(url: url))
        webKit.allowsBackForwardNavigationGestures = true
    }
    
    //MARK: - Web View - func
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Navigation is started")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Navigation is stopped")
    }
}

