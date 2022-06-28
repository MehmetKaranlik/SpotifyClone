//
//  HomeViewModel.swift
//  Spotify
//
//  Created by mehmet karanlık on 29.06.2022.
//

import Foundation
import UIKit
import Combine

class HomeViewModel : BaseViewModel {

   var cancellables = Set<AnyCancellable>()


   override init() {
      super.init()
   }



   func didUserUpdated(user didSet : @escaping (User) -> Void) -> Void {
      let keyWindow = Helpers.returnKeyWindow()
      let root = keyWindow?.rootViewController as! MainViewController

         root.viewModel.$user.sink { user in
            DispatchQueue.main.async {
               if let user {
                  didSet(user)
               }
            }
         }
         .store(in: &self.cancellables)


   }
}
