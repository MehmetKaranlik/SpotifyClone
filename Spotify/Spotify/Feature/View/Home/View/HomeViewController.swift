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
   lazy var settingsBarButtonItem : UIBarButtonItem = {
      let image = UIImage(systemName: "gear.circle")
      let button = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(didTapSettingsButton))

      return button
   }()


      // MARK: Selectors

   @objc func didTapSettingsButton(){
      let vc = SettingsViewController()
      navigationController?.pushViewController(vc, animated: true)
   }

      // MARK: Lifecyle

   override func viewDidLoad() {
      super.viewDidLoad()
      view.backgroundColor = .black
      Utilities.configureNavBar(vc: self, title: "Home")
      configureNavBar()
   
   }

      // MARK:  Makers

   func configureNavBar() {
      navigationItem.rightBarButtonItem = settingsBarButtonItem
   }
}

