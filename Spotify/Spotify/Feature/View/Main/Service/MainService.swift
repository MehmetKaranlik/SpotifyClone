//
//  MainService.swift
//  Spotify
//
//  Created by mehmet karanlık on 26.06.2022.
//

import Foundation
struct MainService : IMainService {
   var networkManager: NetworkManager 

   func fetchCurrentUser() async -> User? {
      let result = await networkManager.send(
         networkPath: NetworkPaths.baseURL.rawValue + "/me",
         parseModel: User.self,
         requestType: .GET, body: nil,
         headerType: .STANDART, bodyType: .JSON, queryParameters: nil)
      return result.data
   }


}
