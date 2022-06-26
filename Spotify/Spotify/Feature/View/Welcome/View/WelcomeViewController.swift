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
   let authManager : AuthManager = AuthManager()

   let loginButton : UIButton = {
      let button = UIButton(type: .custom)
      button.setTitle("Login with Spotify", for: .normal)
      button.layer.cornerRadius = 5
      button.setTitleColor(UIColor.black, for: .normal)
      button.addTarget(self, action: #selector(didTappedLoginButton), for: .touchUpInside)
      button.backgroundColor = .white
      return button
   }()

   let iconView : UIImageView = {
      let iv = UIImageView()
      iv.image = UIImage(named: "spotify_icon")
      iv.contentMode = .scaleAspectFill
      return iv
   }()


      // MARK: Lifecyle
   
   override func viewDidLoad() {
      super.viewDidLoad()
      setUpNavBar()
      setUpView()
      configureLoginButton()
      configureIconView()
   }



      // MARK: Selectors


   @objc func didTappedLoginButton( _ sender : UIButton) {
      let vc = LoginViewController { [weak self] success in
         print("Result : \(success)")
         self?.handleOnComplete(success)
      }
      vc.navigationItem.largeTitleDisplayMode = .never
      navigationController?.pushViewController(vc, animated: true)
   }


      // MARK:  Makers

   func setUpNavBar() {
      title = "Side Product"
      navigationController?
         .navigationBar
         .largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
      self.navigationController?
         .navigationBar
         .prefersLargeTitles = true
      view.backgroundColor = .black
   }

   func setUpView(){
      view.addSubview(loginButton)
      view.addSubview(iconView)
   }



   func configureLoginButton(){
      loginButton.snp.makeConstraints { make in
         make.left.equalTo(view).inset(25)
         make.right.equalTo(view).inset(25)
         make.bottom.equalTo(view).inset(100)
         make.height.equalTo(50)
      }
   }

   func configureIconView() {
      iconView.snp.makeConstraints { make in
         make.centerX.equalTo(view)
         make.centerY.equalTo(view)
         make.width.height.equalTo(250)
      }
   }

   func handleOnComplete(_ success : Bool) {
      if success  {
         DispatchQueue.main.async {
            let vc = MainViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            self.navigationController?.isNavigationBarHidden = true
         }
      }
   }

}

