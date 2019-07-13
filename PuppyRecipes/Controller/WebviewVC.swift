//
//  WebviewVC.swift
//  PuppyRecipes
//
//  Created by jos on 7/11/19.
//  Copyright © 2019 My Organization. All rights reserved.
//

import UIKit
import WebKit

class WebviewVC: UIViewController {
    
    @IBOutlet weak var recipeWebView: WKWebView!
    var href: String?
    
    override func loadView() {
        super.loadView()
        print("loadView()")
        let webConfig = WKWebViewConfiguration()
        recipeWebView = WKWebView(frame: .zero, configuration: webConfig)
        recipeWebView.uiDelegate = self
        recipeWebView.navigationDelegate = self
        view = recipeWebView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let href = self.href {
            print("href: \(href)")
            let url = URL(string: href)
            recipeWebView.load(URLRequest(url: url!))
            
            let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: recipeWebView, action: #selector(recipeWebView.reload))
            toolbarItems = [refresh]
            navigationController?.isToolbarHidden = false
        } else {
            showAlertView(titulo: "Alerta!", mensaje: "La receta no contiene URL", actionTitle: "OK")
        }
    }
}

extension WebviewVC: WKUIDelegate, WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = recipeWebView.title
        print("didFinish navigation")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("didFail navigation withError: \(error)")
        showAlertView(titulo: "Error de Navegacion", mensaje: "Hubo un error desconocido", actionTitle: "Ok")
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("start to load")
    }
    
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        print("webViewWebContentProcessDidTerminate")
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("didFailProvisionalNavigation:")
        print(error.localizedDescription)
    }
    
    func webViewDidClose(_ webView: WKWebView) {
        print("webViewDidClose")
    }
}

extension UIViewController {
    func showAlertView(titulo: String, mensaje: String, actionTitle: String) {
        let alertController = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        let okAction = UIAlertAction(title: actionTitle, style: UIAlertActionStyle.default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
