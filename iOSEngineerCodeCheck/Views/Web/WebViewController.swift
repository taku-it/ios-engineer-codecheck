//
//  WebViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 生田拓登 on 2022/07/13.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit
import WebKit

final class WebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    private var urlString: String?
    func inject(urlString: String?) {
        self.urlString = urlString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWeb()
    }
    
    func loadWeb() {
        guard let urlString = urlString,
              let url = URL(string: urlString)
        else { return }
        webView.load(URLRequest(url: url))
    }
    
}
