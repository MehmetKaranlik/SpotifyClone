//
//  LoginViewController.swift
//  Spotify
//
//  Created by mehmet karanlık on 23.06.2022.
//

import Foundation
import SnapKit
import UIKit
import WebKit

class LoginViewController: UIViewController {
   // MARK: properties

   typealias CompletionHandler = (Bool) -> ()

   let authManager = AuthManager()

   let onSuccess: CompletionHandler

   lazy var webView: WKWebView = {
      let pref = WKPreferences()
      pref.javaScriptCanOpenWindowsAutomatically = true
      let configuration = WKWebViewConfiguration()
      configuration.preferences = pref
      let webView = WKWebView(frame: .zero, configuration: configuration)
      return webView
   }()

   init(_ onComplete: @escaping CompletionHandler) {
      self.onSuccess = onComplete
      super.init(nibName: nil, bundle: nil)
   }

   @available(*, unavailable)
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
      let urlRequest =  URLRequest(url: authManager.signInURL!)
         webView.load(urlRequest)
   }

      // MARK: Makers
}


extension LoginViewController: WKNavigationDelegate {
   func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
      guard let url = webView.url else { return }
      let components = URLComponents(string: url.absoluteString)
      guard let code = components?.queryItems?.first(where: { $0.name == "code" })?.value else { return }
      // leaving this view
      self.navigationController?.popViewController(animated: true)

         Task {
            await self.authManager.excangeTokenWithCode(code) { [unowned self] success in
               self.onSuccess(success)
            }
         }
      
   }
}
