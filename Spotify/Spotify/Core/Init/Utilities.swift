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
      let appereance = Utilities.navBarAppereance

      appereance.backgroundColor = .black
      appereance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
      appereance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

      vc.navigationController?.navigationBar.compactAppearance = appereance
      vc.navigationController?.navigationBar.scrollEdgeAppearance = appereance
      vc.navigationController?.navigationBar.standardAppearance = appereance

      vc.navigationController?.navigationBar.prefersLargeTitles = true
      vc.navigationController?.navigationItem.largeTitleDisplayMode = .automatic

      vc.title = title

   }

   static func spotifyOAuth2URLGenerator(baseUrl : String,clientID : String,scopes : String, redirectURI: String) -> String {
      let string = baseUrl + "response_type=code" + "&client_id=" + clientID + "&scope=" + scopes + "&redirect_uri=" + redirectURI+"&show_dialog=true"


      return string
   }
}
