//
//  LibraryViewController.swift
//  Spotify
//
//  Created by mehmet karanlık on 23.06.2022.
//

import Foundation
import UIKit


class LibraryViewController : UIViewController {
      // MARK:  properties


      // MARK: Lifecyle


      // MARK: Selectors

   override func viewDidLoad() {
      Utilities.configureNavBar(vc: self, title: "Library")
      view.backgroundColor = .systemBackground
      super.viewDidLoad()
   }

      // MARK:  Makers

}

