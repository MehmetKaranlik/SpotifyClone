//
//  WelcomeViewController.swift
//  Spotify
//
//  Created by mehmet karanlık on 23.06.2022.
//

import Foundation

import UIKit


class WelcomeViewController : UIViewController {
      // MARK:  properties
   let loginButton : UIButton = {
      let button = UIButton(type: .custom)
      button.setTitle("Login with Spotify", for: .normal)
      button.layer.cornerRadius = 5
      button.setTitleColor(UIColor.black, for: .normal)
      button.addTarget(self, action: #selector(didTappedLoginButton), for: .touchUpInside)
      button.backgroundColor = .white
      return button
   }()

      // MARK: Lifecyle
   
   override func viewDidLoad() {
      super.viewDidLoad()
      title = "Spotify"
      self.navigationController?.navigationBar.prefersLargeTitles = true
      view.backgroundColor = .systemGreen
      view.addSubview(loginButton)
      configureLoginButton()
   }



      // MARK: Selectors


   @objc func didTappedLoginButton( _ sender : UIButton) {
      let vc = LoginViewController()
      vc.navigationItem.largeTitleDisplayMode = .never
      navigationController?.pushViewController(vc, animated: true)
   }


      // MARK:  Makers

   func configureLoginButton(){
      loginButton.snp.makeConstraints { make in
         make.left.equalTo(view).inset(25)
         make.right.equalTo(view).inset(25)
         make.bottom.equalTo(view).inset(50)
         make.height.equalTo(50)
      }
   }

}

