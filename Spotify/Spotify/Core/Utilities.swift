//
//  Utilities.swift
//  Spotify
//
//  Created by mehmet karanlık on 23.06.2022.
//

import Foundation
import UIKit

struct Utilities {

   static let navBarAppereance = UINavigationBarAppearance()

   static func configureNavBar(vc: UIViewController, title: String) {
//      vc.navigationController?.navigationBar.compactAppearance = Utilities.navBarAppereance
//      vc.navigationController?.navigationBar.scrollEdgeAppearance = Utilities.navBarAppereance
//      vc.navigationController?.navigationBar.standardAppearance = Utilities.navBarAppereance
      vc.navigationController?.navigationBar.prefersLargeTitles = true
      vc.title = title
      vc.navigationController?.navigationItem.largeTitleDisplayMode = .always

   }
}
