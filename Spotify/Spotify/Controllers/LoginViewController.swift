//
//  LoginViewController.swift
//  Spotify
//
//  Created by mehmet karanlık on 23.06.2022.
//

import Foundation
import UIKit
import SnapKit
import WebKit

class LoginViewController : UIViewController {
      // MARK:  properties


   lazy var webView : WKWebView = {
      let pref = WKPreferences()
      pref.javaScriptCanOpenWindowsAutomatically = true
      let configuration = WKWebViewConfiguration()
      configuration.preferences = pref
      let webView = WKWebView(frame: .zero, configuration: configuration)
      return webView
   }()


      // MARK: Lifecyle

   override func viewDidLoad() {

      view.addSubview(webView)
      webView.navigationDelegate = self

      super.viewDidLoad()
   }
      // MARK: Selectors


   override func viewDidLayoutSubviews() {
      webView.frame = view.bounds
   }


      // MARK:  Makers



}



extension LoginViewController : WKNavigationDelegate {

}
