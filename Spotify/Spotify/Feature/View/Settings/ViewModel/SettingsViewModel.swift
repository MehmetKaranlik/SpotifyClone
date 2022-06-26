//
//  SettingsViewModel.swift
//  Spotify
//
//  Created by mehmet karanlık on 27.06.2022.
//

import Foundation
import UIKit

class SettingsViewModel : BaseViewModel {
   lazy var sections : [Section] = [
      Section(title: "Profile", options: [
         Section.Option(title: "View Your Profile", handler: navigateToProfile)
      ]),
      Section(title: "Account", options: [
         Section.Option(title: "Sign Out", handler: signOutTapped)
      ])
   ]





   func navigateToProfile(vc : UIViewController) {
      let profVC = ProfileViewController()
      profVC.title = "Profile"
      vc.navigationController?.pushViewController(profVC, animated: true)
   }

   func signOutTapped(vc : UIViewController) {
      let welcomeVC = WelcomeViewController()
      welcomeVC.navigationController?.navigationItem.hidesBackButton = true
      UIApplication
         .shared
         .keyWindow?
         .rootViewController = UINavigationController(rootViewController: welcomeVC)
   }

}

// custom section model
extension SettingsViewModel {
   struct Section {
      let title : String
      let options : [Option]

      struct Option {
         let title : String
         let handler : (UIViewController) -> Void
      }
   }
}
