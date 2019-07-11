//
//  WebviewVC.swift
//  PuppyRecipes
//
//  Created by jos on 7/11/19.
//  Copyright © 2019 My Organization. All rights reserved.
//

import UIKit
import WebKit

class WebviewVC: UIViewController, WKUIDelegate {
    
    @IBOutlet weak var recipeWebView: WKWebView!
    var href: String?
    
    override func loadView() {
        super.loadView()
        print("loadView()")
        let webConfig = WKWebViewConfiguration()
        recipeWebView = WKWebView(frame: .zero, configuration: webConfig)
        recipeWebView.uiDelegate = self
        view = recipeWebView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        let url = URL(string: "https://www.apple.com")
        let request = URLRequest(url: url! as URL)
        recipeWebView.load(request)
         */
        
        if let href = self.href {
            print("href: \(href)")
            let url = URL(string: href)
            recipeWebView.load(URLRequest(url: url!))
            
            let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: recipeWebView, action: #selector(recipeWebView.reload))
            toolbarItems = [refresh]
            navigationController?.isToolbarHidden = false
        } else {
            print("No href")
        }
        
    }
    
   
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = recipeWebView.title
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("start to load")
    }
    
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        print("webViewWebContentProcessDidTerminate")
    }
    
}
