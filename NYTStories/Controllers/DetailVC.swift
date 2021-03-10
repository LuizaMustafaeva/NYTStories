//
//  DetailVC.swift
//  NYTStories
//
//  Created by Luiza on 10.03.2021.
//  Copyright © 2021 Luiza. All rights reserved.
//

import UIKit
import WebKit

class DetailVC: UIViewController {
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var webView: WKWebView!
    
       var urlString: URL?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let request = URLRequest(url: urlString!)
            
            webView.backgroundColor = .clear
            webView.load(request)
            webView.allowsBackForwardNavigationGestures = true
            webView.navigationDelegate = self
            webView.addObserver(self,
                                forKeyPath: #keyPath(WKWebView.estimatedProgress),
                                options: .new,
                                context: nil)
        }
        
        override func observeValue(forKeyPath keyPath: String?,
                                   of object: Any?,
                                   change: [NSKeyValueChangeKey : Any]?,
                                   context: UnsafeMutableRawPointer?) {
            
            if keyPath == "estimatedProgress" {
                progressView.progress = Float(webView.estimatedProgress)
            }
        }
        
        private func showProgressView() {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                self.progressView.alpha = 1
            }, completion: nil)
        }
        
        private func hideProgressView() {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                self.progressView.alpha = 0
            }, completion: nil)
        }
    }

    extension DetailVC: WKNavigationDelegate {
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            showProgressView()
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            hideProgressView()
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            hideProgressView()
        }
    }
