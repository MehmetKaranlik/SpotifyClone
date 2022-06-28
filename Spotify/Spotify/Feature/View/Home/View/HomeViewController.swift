//
//  HomeViewController.swift
//  Spotify
//
//  Created by mehmet karanlık on 23.06.2022.
//

import Foundation
import UIKit


class HomeViewController : UIViewController {
      // MARK:  properties

   let viewModel = HomeViewModel()
   lazy var settingsBarButtonItem : UIBarButtonItem = {
      let image = UIImage(systemName: "gear.circle")

      let button = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(didTapSettingsButton))
      button.tintColor = .systemGreen

      return button
   }()

   lazy var profileImageBarButtonItem : UIBarButtonItem = {
      let iv = UIImageView()
      iv.heightAnchor.constraint(equalToConstant: 44).isActive = true
      iv.widthAnchor.constraint(equalToConstant: 44).isActive = true
      iv.layer.cornerRadius = 22
      iv.layer.borderWidth = 1
      iv.clipsToBounds = true
      iv.layer.borderColor =  .init(gray: 1, alpha: 1)
      let button = UIBarButtonItem(customView: iv)
      let tapR = UITapGestureRecognizer(target: self, action: #selector(didTapProfileImage))
      iv.addGestureRecognizer(tapR)
      return button
   }()


      // MARK: Selectors

   @objc func didTapSettingsButton(){
      let vc = SettingsViewController()
      navigationController?.pushViewController(vc, animated: true)
   }

   @objc func didTapProfileImage() {
      let vc = ProfileViewController()
      navigationController?.pushViewController(vc, animated: true)
   }

      // MARK: Lifecyle

   override func viewDidLoad() {
      super.viewDidLoad()
      view.backgroundColor = .systemBackground
      Utilities.configureNavBar(vc: self, title: "Home")
      configureNavBar()
   
   }

   override func viewDidAppear(_ animated: Bool) {
      viewModel.didUserUpdated { [unowned self] user in
         let imageView = self.profileImageBarButtonItem.customView as! UIImageView
         guard let url = URL(string: user.images!.first!.url!) else { return }
         imageView.load(url: url)
      }
   }

      // MARK:  Makers

   func configureNavBar() {
      navigationItem.rightBarButtonItem = settingsBarButtonItem
      configureProfileImage()
   }

   func configureProfileImage(){
      navigationItem.leftBarButtonItem = profileImageBarButtonItem
      let customView = profileImageBarButtonItem.customView as! UIImageView
      
   }
}

