//
//  WebViewController.swift
//  ihshin_project
//
//  Created by Ilho Shin on 2023/06/17.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {

    
    @IBOutlet weak var WebView: WKWebView!
    var wtxt: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WebView.navigationDelegate = self
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
    
        
        let wtxtEncoding = wtxt.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed.union(.urlFragmentAllowed)) ?? ""
        let urlStr = "https://www.google.com/search?q=" + wtxtEncoding
        
        let url = URL(string: urlStr)!
        let request = URLRequest(url: url)
        WebView.load(request)

    }
    
    @IBAction func back(_ sender: UIButton) {
        if WebView.canGoBack {
            WebView.goBack()
        }
    }
    
    @IBAction func forward(_ sender: UIButton) {
        if WebView.canGoForward {
            WebView.goForward()
        }
    }

}
