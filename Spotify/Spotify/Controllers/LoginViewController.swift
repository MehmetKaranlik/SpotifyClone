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

   let authManager = AuthManager()
   typealias CompletionHandler = (Bool) -> ()
   let onSuccess : (Bool) -> ()
   lazy var webView : WKWebView = {
      let pref = WKPreferences()
      pref.javaScriptCanOpenWindowsAutomatically = true

      let configuration = WKWebViewConfiguration()

      configuration.preferences = pref
      let webView = WKWebView(frame: .zero, configuration: configuration)

      return webView
   }()

   init(_ onComplete : @escaping CompletionHandler) {
      self.onSuccess = onComplete
      super.init(nibName: nil, bundle: nil)
   }

   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }


      // MARK: Lifecyle

   override func viewDidLoad() {

      view.addSubview(webView)
      webView.navigationDelegate = self

      super.viewDidLoad()
   }
      // MARK: Selectors


   override func viewDidLayoutSubviews() {
      webView.frame = view.bounds
      Task {
         let urlRequest = await URLRequest(url: authManager.signInUrl!)
         webView.load(urlRequest)

      }
   }


      // MARK:  Makers



}



extension LoginViewController : WKNavigationDelegate {

   func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {

         guard let url = webView.url else { return }
         let components = URLComponents(string: url.absoluteString)
         print("burasi calisti")
         print(components?.queryItems)
         let code = components?.queryItems?.first(where: { $0.name == "code" })?.value
         print("Code : \(code)")

   }

}
