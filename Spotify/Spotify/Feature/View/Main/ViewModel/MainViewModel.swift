//
//  MainViewModel.swift
//  Spotify
//
//  Created by mehmet karanlık on 26.06.2022.
//

import Foundation


class MainViewModel : BaseViewModel {
   private lazy var service : IMainService = MainService(networkManager: networkManager)

   override init() {
      super.init()
      fetchUser()
   }





   func fetchUser() {
      Task {
         await service.fetchCurrentUser()
      }
   }


}
