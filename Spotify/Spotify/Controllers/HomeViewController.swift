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


      // MARK: Lifecyle


      // MARK: Selectors

   override func viewDidLoad() {
      super.viewDidLoad()
      view.backgroundColor = .systemBackground
      Utilities.configureNavBar(vc: self, title: "Home")
   
   }

      // MARK:  Makers

}

