//
//  UIImage + Extensions.swift
//  Spotify
//
//  Created by mehmet karanlık on 29.06.2022.
//

import Foundation
import UIKit


extension UIImageView {
   func load(url : URL) {
      DispatchQueue.global().async {
         guard let data = try? Data(contentsOf: url) else { return }
         guard let image = UIImage(data: data) else { return }
         DispatchQueue.main.async {
            self.image = image
         }

      }
   }
}
