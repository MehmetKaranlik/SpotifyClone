//
//  BaseViewController.swift
//  Spotify
//
//  Created by mehmet karanlık on 23.06.2022.
//

import Foundation


import Foundation
import UIKit


class BaseViewController : UITabBarController {
      // MARK:  properties
   let homeViewController = UINavigationController(rootViewController: HomeViewController())
   let searchViewController = UINavigationController(rootViewController: SearchViewController())
   let libraryViewController = UINavigationController(rootViewController: LibraryViewController())

   let symbols = ["house","magnifyingglass","book"]
   let name = ["Home", "Search", "Library"]

      // MARK: Lifecyle


      // MARK: Selectors

   override func viewDidLoad() {
      super.viewDidLoad()
      configureChildViews()
      configureTabBar()

   }

      // MARK:  Makers

   func configureChildViews() {

      self.viewControllers = [homeViewController,searchViewController,libraryViewController]
      viewControllers?.forEach({ controller in
         print(controller)
         let index = viewControllers?.firstIndex(of: controller)
         controller.tabBarItem = UITabBarItem(title: name[index!], image: UIImage(systemName: symbols[index!]), tag: index!)
      })
   }

   func configureTabBar() {
      tabBar.backgroundColor = UIColor.secondarySystemGroupedBackground
   }

}

