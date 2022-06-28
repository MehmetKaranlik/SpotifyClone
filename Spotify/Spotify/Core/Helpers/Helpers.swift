   //
   //  Utilities.swift
   //  Spotify
   //
   //  Created by mehmet karanlık on 29.06.2022.
   //

import Foundation
import UIKit


struct Helpers {


   static func returnKeyWindow() -> UIWindow? {
      guard let windows = UIApplication.shared
         .connectedScenes.filter({ $0.activationState == .foregroundActive })
         .compactMap({ $0 as? UIWindowScene })
         .first?.windows,
            let keyWindow = windows.filter({ $0.isKeyWindow }).first
      else { return nil }
      return keyWindow
   }
}
