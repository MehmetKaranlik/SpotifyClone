//
//  BaseViewController.swift
//  Spotify
//
//  Created by mehmet karanlık on 23.06.2022.
//

import Foundation


import Foundation
import UIKit


class MainViewController : UITabBarController {
      // MARK:  properties
   let viewModel = MainViewModel()
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
         let index = viewControllers?.firstIndex(of: controller)
         controller.tabBarItem = UITabBarItem(title: name[index!], image: UIImage(systemName: symbols[index!]), tag: index!)

      })
   }

   func configureTabBar() {
      let appereance = UITabBarAppearance()
      appereance.backgroundEffect = UIBlurEffect(style: .systemChromeMaterialLight)
      appereance.backgroundColor = .systemGroupedBackground.withAlphaComponent(0.8)

      tabBar.standardAppearance = appereance
      tabBar.unselectedItemTintColor = .white
      tabBar.tintColor = .systemGreen
      tabBar.scrollEdgeAppearance = appereance


   }

}

